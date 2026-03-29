<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$data = json_decode(file_get_contents('php://input'), true);
$response = ['status' => 'error', 'message' => 'Invalid payload', 'synced_count' => 0];

if ($data && isset($data['sessions']) && isset($data['houses'])) {
    include_once 'config.php';
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if ($conn->connect_error) {
        $response['message'] = 'Database connection failed: ' . $conn->connect_error;
        echo json_encode($response);
        exit;
    }
    $synced = 0;
    foreach ($data['sessions'] as $session) {
        $stmt = $conn->prepare("REPLACE INTO monitoring_sessions (id, monitor_name, designation, posting_place, mobile_no, district, institution, monitoring_date, monitoring_time, is_high_risk_area, block_name, area_type, village_ward_name, form_status, synced, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('ssssssssissssiiiis', $session['id'], $session['monitor_name'], $session['designation'], $session['posting_place'], $session['mobile_no'], $session['district'], $session['institution'], $session['monitoring_date'], $session['monitoring_time'], $session['is_high_risk_area'], $session['block_name'], $session['area_type'], $session['village_ward_name'], $session['form_status'], $session['synced'], $session['created_at'], $session['updated_at']);
        if ($stmt->execute()) {
            $synced++;
        }
        $stmt->close();
    }
    foreach ($data['houses'] as $house) {
        $fields = array_keys($house);
        $placeholders = implode(', ', array_fill(0, count($fields), '?'));
        $types = '';
        $values = [];
        foreach ($fields as $field) {
            $types .= 's';
            $values[] = $house[$field];
        }
        $sql = 'REPLACE INTO house_monitoring_data (' . implode(', ', $fields) . ') VALUES (' . $placeholders . ')';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param($types, ...$values);
        $stmt->execute();
        $stmt->close();
    }
    $response = ['status' => 'success', 'synced_count' => $synced];
}

echo json_encode($response);

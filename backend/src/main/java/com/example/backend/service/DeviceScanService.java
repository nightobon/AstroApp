package com.example.backend.service;

import com.example.backend.model.ScanResult;
import org.springframework.stereotype.Service;

@Service
public class DeviceScanService {

    public ScanResult scanDevice(String scanType) {
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        ScanResult result = new ScanResult();
        result.setScanType(scanType);
        result.setResult("Your device is Secured");

        if (Math.random() < 0.3) {
            result.setResult("Your device is In Risk");
        }

        return result;
    }
}

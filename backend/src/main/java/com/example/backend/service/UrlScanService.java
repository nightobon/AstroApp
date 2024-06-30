package com.example.backend.service;

import com.example.backend.model.ScanResult;
import org.springframework.stereotype.Service;

@Service
public class UrlScanService {

    public ScanResult scanUrl(String url) {
        ScanResult result = new ScanResult();
        result.setScanType("URL Scan");
        result.setResult("Scanned URL: " + url);

        if (Math.random() < 0.3) {
            result.setResult("URL is potentially unsafe: " + url);
        }

        return result;
    }
}

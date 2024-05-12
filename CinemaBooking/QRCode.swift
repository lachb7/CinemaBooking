//
//  QRCode.swift
//  CinemaBooking
//
//  Created by 騎呢怪 on 13/5/2024.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCode: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var url : String
    
    var body: some View {
        Image(uiImage: generateQRcodeImage(url))
            .interpolation(.none)
            .resizable()
            .frame(width: 150, height: 150, alignment: .center)
    }
    
    func generateQRcodeImage(_ url : String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
            return UIImage(systemName: "xmark") ?? UIImage()
        
    }
}

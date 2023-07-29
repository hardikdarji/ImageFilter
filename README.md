# ImageFilter

ImageFilter is App in iOS Swift with MVVM which is having functionality of Image Filters using CoreImage Apple APIs
<img src="https://github.com/hardikdarji/ImageFilter/blob/main/demo1_small.png" alt="Demo: Apply filter from options">
<img src="https://github.com/hardikdarji/ImageFilter/blob/main/demo2_small.png" alt="Demo: GaussianBlur filter Applied">

# Filters
- GaussianBlur
- BoxBlur
- Brightness
- Saturation
- Contrast

# MVVM Architecture

Here is exersice conducted here:

**1. User Interface:**
   - Design a simple and intuitive interface that includes an image view to display the selected image and sliders to control the filter parameters.
   - Implement sliders for Gaussian blur, box blur, brightness adjustment, contrast adjustment, and saturation adjustment.
   - Display the filtered image in real-time as the user adjusts the sliders.

**2. Image Selection:**
   - Allow the user to select an image from their photo library or capture a new photo using the device's camera.

**3. Core Image Integration:**
   - Utilize the Core Image framework to apply the desired image filters.
   - Implement the following filters:
     - Gaussian Blur: Allow the user to adjust the blur radius using a slider.
     - Box Blur: Allow the user to adjust the blur radius using a slider.
     - Brightness Adjustment: Allow the user to adjust the brightness level using a slider.
     - Contrast Adjustment: Allow the user to adjust the contrast level using a slider.
     - Saturation Adjustment: Allow the user to adjust the saturation level using a slider.

**4. Real-Time Filter Application:**
   - Apply the selected image filter in real-time as the user adjusts the corresponding slider.
   - Ensure smooth performance even when the user rapidly adjusts the sliders.

**5. Reset and Save Options:**
   - Provide a reset button to reset all filter values and revert the image to its original state.
   - Allow the user to save the filtered image to their photo library.

**6. User-Friendly Experience:**
   - Implement appropriate feedback mechanisms, such as displaying filter parameter values, slider labels, and real-time preview updates.
   - Consider usability and aesthetics to provide an enjoyable user experience.




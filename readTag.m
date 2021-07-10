function [d1image] = readTag(fName,input_size)
%takes input of .TAG file from SliceOMatic software
%outputs an N-d image of the binary.
% fname is the fileName and input_size should be an array like so: [512,
% 512].
    
    file_handle = fopen(fName); % open the TAG file
    A = fread(file_handle); % read the tag file into A
    fclose(file_handle); % close the file
    
    whos A
    % Now we have a file, however, we want it in size 262144x1 (which is 512x512) but there is
    % a header.
    
    arr_size = size(A);
    arr_size = arr_size(1); %get len of the arr
    
    %del the header by cutting out until we reach the input_size in 1d
    to_trim = arr_size - prod(input_size);
    A(1:to_trim) = [];
    
    %reshape from [1x262144] (since I have 512x512 image) to input_size.
    d1image = reshape(A,input_size);
    
    %transpose and read as uint16
    d1image = uint16(d1image)';
    imshow(d1image,[]);
    
    %write image in .tiff. .tiff can be used for something like a pxds.
    %however, I would recommend looking into saving the uint16 as it is,
    %and then using the matReader within the pxds to import your data.
end

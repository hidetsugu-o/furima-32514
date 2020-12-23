const preview = () => {
  const ImageList = document.getElementById("image-list");

  const createImageHTML = (blob) => {
    const imageElement = document.createElement('div');
    
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', 'preview-image')

    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
  };

  document.getElementById("item-image").addEventListener('change', (e) => {

    const imageContent = document.getElementById('preview-image')
    if (imageContent){
      imageContent.remove();
    }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    createImageHTML(blob);
  });
};
window.addEventListener("load", preview);
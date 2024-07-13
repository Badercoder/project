const aboutSection = document.querySelector(".about");
const aboutLogo = document.querySelector(".about__image");

aboutLogo.addEventListener("click", () => {
    aboutSection.classList.toggle("opacity")
})

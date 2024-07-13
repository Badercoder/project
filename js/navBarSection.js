const navLinks = document.querySelectorAll(".nav__link");
const sections = document.querySelectorAll(".section");

/*--# move active link to current section #--*/

let activeSection = "";

window.addEventListener("scroll", () => {
    sections.forEach(section => {
        if( window.scrollY >= ( section.offsetTop - section.clientHeight * 0.4 )) {

            activeSection = section.id;
        }
    })

    navLinks.forEach(navlink => {
        if( navlink.href.includes( activeSection ) ) {
            document.querySelector(".nav__link.active").classList.remove("active")
            navlink.classList.add("active");
        }
    })
})


/*--# close navMenue on navLink click #--*/

const navButton = document.getElementById("navButton");

navLinks.forEach((link) => {
    link.addEventListener("click", () => {
        navButton.checked = false;
    })
})

/*--# dynamic apply scroll-padding-top #--*/
const navBarHeight = document.querySelector(".nav").clientHeight;

document.documentElement.style.setProperty("--navBar-height", navBarHeight + "px")
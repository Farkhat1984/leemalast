document.addEventListener('DOMContentLoaded', function() {
    // Добавление функционала для кнопки
    const ctaButton = document.getElementById('ctaButton');
    ctaButton.addEventListener('click', () => {
        window.location.href = '/home';
    });
});

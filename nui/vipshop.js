window.addEventListener('message', function(event) {
    const data = event.data;
    if (data.action === "openShop") {
        document.getElementById('shop-container').style.display = 'block';
        const itemsContainer = document.getElementById('items-container');
        itemsContainer.innerHTML = ''; 

        data.items.forEach(item => {
            const itemElement = document.createElement('div');
            itemElement.className = 'shop-item';
            itemElement.innerHTML = `
                <img src="nui://sv_vip/nui/images/items/${item.img}" alt="${item.label}"> <!-- Korrekte Bild-URL -->
                <h2>${item.label}</h2>
                <p>Preis: <img src="nui://sv_vip/nui/images/items/gold_muenze.png" alt="Goldmünze" style="width: 20px; height: 20px; vertical-align: middle;"> ${item.price}</p>
                <button onclick="openConfirmationModal('${item.item}', ${item.price})">Kaufen</button>
            `;
            itemsContainer.appendChild(itemElement);
        });
    } else if (data.action === "closeShop") {
        document.getElementById('shop-container').style.display = 'none';
    }
});

function openConfirmationModal(item, price) {
    const modal = document.getElementById('confirmation-modal');
    const confirmButton = document.getElementById('confirm-buy');
    const cancelButton = document.getElementById('cancel-buy');

    modal.style.display = 'flex';

    confirmButton.onclick = function () {
        buyItem(item, price);
        modal.style.display = 'none'; 
    };

    cancelButton.onclick = function () {
        modal.style.display = 'none';
    };

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            modal.style.display = 'none'; 
        }
    }, { once: true }); 
}


function buyItem(item, price) {
    fetch(`https://${window.GetParentResourceName()}/buyItem`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            item: item,
            price: price
        })
    }).then(response => response.json()).then(response => {
        if (!response.success) {
        }
    }).catch(error => {
    });
}

document.getElementById('close-shop').addEventListener('click', function() {
    fetch(`https://${window.GetParentResourceName()}/closeShop`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {
        document.getElementById('shop-container').style.display = 'none';
    });
});

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        fetch(`https://${window.GetParentResourceName()}/closeShop`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(resp => {
            document.getElementById('shop-container').style.display = 'none';
        });
    }
});














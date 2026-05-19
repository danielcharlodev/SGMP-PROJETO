let currentStep = 1;
const TOTAL_STEPS = 3;

function goToStep(target) {
    const from = currentStep;
    if (target === from) return;

    // Mark leaving step
    const fromDot = document.getElementById('step-dot-' + from);
    if (target > from) {
        fromDot.classList.remove('active');
        fromDot.classList.add('done');
    } else {
        fromDot.classList.remove('done', 'active');
    }

    // Update lines
    for (let i = 1; i < TOTAL_STEPS; i++) {
        const line = document.getElementById('line-' + i);
        if (line) line.classList.toggle('done', i < target);
    }

    // Activate target step dot
    for (let i = 1; i <= TOTAL_STEPS; i++) {
        const dot = document.getElementById('step-dot-' + i);
        if (i < target) {
            dot.classList.add('done');
            dot.classList.remove('active');
        } else if (i === target) {
            dot.classList.add('active');
            dot.classList.remove('done');
        } else {
            dot.classList.remove('active', 'done');
        }
    }

    // Hide/show form steps
    document.getElementById('form-step-' + from).classList.add('hidden');
    document.getElementById('form-step-' + target).classList.remove('hidden');

    currentStep = target;
}

// Mascara CPF
document.getElementById('cpf_cdt').addEventListener('input', function () {
    let v = this.value.replace(/\D/g, '').slice(0, 11);
    v = v.replace(/(\d{3})(\d)/, '$1.$2');
    v = v.replace(/(\d{3})(\d)/, '$1.$2');
    v = v.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
    this.value = v;
});

// Mascara telefone
document.getElementById('telefone_cdt').addEventListener('input', function () {
    let v = this.value.replace(/\D/g, '').slice(0, 11);
    if (v.length > 10) {
        v = v.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else {
        v = v.replace(/(\d{2})(\d{4})(\d{0,4})/, '($1) $2-$3');
    }
    this.value = v;
});

// Mascara CEP + consulta ViaCEP
const cepInput = document.getElementById('cep_cdt');
if (cepInput) {
    cepInput.addEventListener('input', function () {
        let v = this.value.replace(/\D/g, '').slice(0, 8);
        if (v.length > 5) v = v.replace(/(\d{5})(\d)/, '$1-$2');
        this.value = v;

        if (v.replace('-', '').length === 8) {
            fetch('https://viacep.com.br/ws/' + v.replace('-', '') + '/json/')
                .then(r => r.json())
                .then(data => {
                    if (!data.erro) {
                        document.getElementById('rua_cdt').value = data.logradouro || '';
                        document.getElementById('bairro_cdt').value = data.bairro || '';
                        document.getElementById('cidade_cdt').value = data.localidade || '';
                        document.getElementById('uf_cdt').value = data.uf || '';
                        document.getElementById('num_cdt').focus();
                    }
                })
                .catch(() => {});
        }
    });
}

// Toggle senha visível
function togglePw(inputId, btn) {
    const input = document.getElementById(inputId);
    const showing = input.type === 'text';
    input.type = showing ? 'password' : 'text';
    btn.style.color = showing ? '' : '#dc2626';
}

// Força da senha
const senhaInput = document.getElementById('senha_cdt');
const pwFill = document.getElementById('pw-fill');
const pwLabel = document.getElementById('pw-label');

if (senhaInput) {
    senhaInput.addEventListener('input', function () {
        const val = this.value;
        let score = 0;
        if (val.length >= 8) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        const levels = [
            { pct: '0%', color: '#e5e7eb', text: '' },
            { pct: '25%', color: '#ef4444', text: 'Fraca' },
            { pct: '50%', color: '#f97316', text: 'Regular' },
            { pct: '75%', color: '#eab308', text: 'Boa' },
            { pct: '100%', color: '#22c55e', text: 'Forte' },
        ];
        const lv = val.length === 0 ? levels[0] : levels[score] || levels[4];
        pwFill.style.width = lv.pct;
        pwFill.style.backgroundColor = lv.color;
        pwLabel.textContent = lv.text;
        pwLabel.style.color = lv.color;
    });
}

function buildEndereco() {
    const rua = document.getElementById('rua_cdt').value;
    const num = document.getElementById('num_cdt').value;
    const bairro = document.getElementById('bairro_cdt').value;
    const cidade = document.getElementById('cidade_cdt').value;
    const uf = document.getElementById('uf_cdt').value;
    const cep = document.getElementById('cep_cdt').value;

    const parts = [rua, num, bairro, cidade, uf, cep].filter(Boolean);
    document.getElementById('endereco_hidden').value = parts.join(', ');
}
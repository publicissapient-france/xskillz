import alt from '../libs/alt';

class DomainStore {
    constructor() {
        this.domains = [
            {
                id: 1,
                name: "Front"
            },
            {
                id: 2,
                name: "Back"
            }
        ];
    }

    create(domain) {
        const domains = this.domains;

        domain.id = domains.length + 1;
        domain.notes = domain.notes || [];

        this.setState({
            domains: domains.concat(domain)
        });
    }
}

export default alt.createStore(DomainStore, 'DomainStore');
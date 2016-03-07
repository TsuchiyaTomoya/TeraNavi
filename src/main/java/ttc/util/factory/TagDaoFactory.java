package ttc.util.factory;

import ttc.dao.AbstractDao;
import ttc.dao.TagDao;

public class TagDaoFactory extends AbstractDaoFactory{
    public AbstractDao getAbstractDao(){
        return new TagDao();
    }
}

Received: from mx1.redhat.com ([209.132.183.28]:34216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933115AbcIZMtd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Sep 2016 08:49:33 -0400
Date: Mon, 26 Sep 2016 20:49:31 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/317: use id to get user id
Message-ID: <20160926124931.GI27776@eguan.usersys.redhat.com>
References: <1474649676-31602-1-git-send-email-eguan@redhat.com>
 <CADxRZqyaupU9ThvAcT7w7vu5LUgV=eGLDSmN2ZXb3By4iYDs5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqyaupU9ThvAcT7w7vu5LUgV=eGLDSmN2ZXb3By4iYDs5g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Anatoly Pugachev <matorola@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 26, 2016 at 12:11:24PM +0300, Anatoly Pugachev wrote:
> On Fri, Sep 23, 2016 at 7:54 PM, Eryu Guan <eguan@redhat.com> wrote:
> >
> > Greping username "fsgqa" in passwd file to get user id doesn't
> > always work, because the given username could match multiple
> > entries, e.g. when we have user "123456-fsgqa" (used by other tests)
> > in passwd file.
> >
> > Fix it by using "id -u $qa_user" to get the user id directly.
> >
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  tests/generic/317 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/generic/317 b/tests/generic/317
> > index 9d9499b..7e40b1f 100755
> > --- a/tests/generic/317
> > +++ b/tests/generic/317
> > @@ -61,7 +61,7 @@ _require_scratch
> >  _require_user
> >  _require_ugid_map
> >  _require_userns
> > -qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
> > +qa_user_id=`id -u $qa_user`
> 
> 
> shouldn't it use _cat_passwd() from common/rc ?

I thought about it too, but _cat_passwd has the same problem as grep
/etc/passwd directly, and "id -u $qa_user" just works fine too in NIS
env. So I think this fix is fine.

Thanks,
Eryu

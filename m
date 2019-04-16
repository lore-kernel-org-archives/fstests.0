Received: from mx1.redhat.com ([209.132.183.28]:43984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfDPILT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Apr 2019 04:11:19 -0400
Date: Tue, 16 Apr 2019 16:11:15 +0800
From: Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] generic/294: skip on NFS
Message-ID: <20190416081115.3vgx7zmqqtkwwoi6@XZHOUW.usersys.redhat.com>
References: <20190304025008.11986-1-xzhou@redhat.com>
 <20190415040309.GN2824@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415040309.GN2824@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 15, 2019 at 12:03:09PM +0800, Eryu Guan wrote:
> On Mon, Mar 04, 2019 at 10:50:08AM +0800, Xiong Zhou wrote:
> > Because NFS handles this differently, returning different values.
> > Details:
> > http://people.redhat.com/bcodding/nfs/2016/10/07/nfs_xfstest_generic/#generic294
> > 
> > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> 
> Sorry for the so long delay.. 

Not at all, :)

Sending v2.

Thanks,
Xiong 

> > ---
> >  tests/generic/294 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/generic/294 b/tests/generic/294
> > index b74579ac..f7e763a3 100755
> > --- a/tests/generic/294
> > +++ b/tests/generic/294
> > @@ -27,6 +27,7 @@ _cleanup()
> >  . ./common/filter
> >  
> >  # real QA test starts here
> > +[ $FSTYP == "nfs" ] && _notrun "NFS behaves differently, breaks golden output"
> 
> I think it's better to filter the output of NFS to follow the golden
> output, so when NFS changes behavior, filter fails and we could know
> that from test failure.
> 
> Thanks,
> Eryu
> 
> >  
> >  # Modify as appropriate.
> >  _supported_fs generic
> > -- 
> > 2.21.0
> > 

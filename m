Received: from mx1.redhat.com ([209.132.183.28]:58928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeG3KuF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jul 2018 06:50:05 -0400
Date: Mon, 30 Jul 2018 17:16:00 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs/288: _notrun if xfs_db write doesn't support -d
 option
Message-ID: <20180730091600.GO4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180730074202.26450-1-zlang@redhat.com>
 <5B5ED155.4010700@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B5ED155.4010700@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 30, 2018 at 04:50:29PM +0800, Xiao Yang wrote:
> Hi Zorro,
> 
> On xfsporgs-dev v4.9.0 which has supported -d option, xfs_db command in
> xfs/288 still failed
> to set the header count of attr to 0. Is this issue casued by
> unsupported -d option on v5 XFS?

Hi,

I sent below patch yesterday:
https://marc.info/?l=linux-xfs&m=153287978423915&w=2

I should sent it with this patch together ... Is that OK after you
merge two patches?

Thanks,
Zorro

> 
> Thanks,
> Xiao Yang
> 
> On 2018/07/30 15:42, Zorro Lang wrote:
> > Commit b3cf8b72334fd35ef961869506e5a72ab398bc82 help xfs/288 to
> > support v5 filesystems testing, but there're still some old
> > distributions don't support xfs_db 'write -d' usage. Then this
> > case fails on them.
> >
> > For compatible with older versions, skip this test on v5 xfs
> > if xfs_db write command doesn't support -d option.
> >
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/288 | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tests/xfs/288 b/tests/xfs/288
> > index bccdb6fc..f8e117ed 100755
> > --- a/tests/xfs/288
> > +++ b/tests/xfs/288
> > @@ -40,6 +40,14 @@ _require_attrs
> >  _scratch_mkfs_xfs 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
> >  . $tmp.mkfs
> >  
> > +# Require write -d option to write invalid data into V5 filesystem
> > +if [ $_fs_has_crcs -eq 1 ]; then
> > +	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)"
> > +	if [ $? -ne 0 ]; then
> > +		_notrun "xfs_db write doesn't support -d option"
> > +	fi
> > +fi
> > +
> >  _scratch_mount
> >  
> >  touch $SCRATCH_MNT/$seq.attrfile
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

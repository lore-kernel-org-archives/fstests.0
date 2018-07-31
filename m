Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeGaFG0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Jul 2018 01:06:26 -0400
Date: Tue, 31 Jul 2018 11:28:15 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs/288: _notrun if xfs_db write doesn't support -d
 option
Message-ID: <20180731032815.GP4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180730074202.26450-1-zlang@redhat.com>
 <5B5ED155.4010700@cn.fujitsu.com>
 <20180730091600.GO4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
 <5B5FC026.4040001@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B5FC026.4040001@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 31, 2018 at 09:49:26AM +0800, Xiao Yang wrote:
> On 2018/07/30 17:16, Zorro Lang wrote:
> > On Mon, Jul 30, 2018 at 04:50:29PM +0800, Xiao Yang wrote:
> > > Hi Zorro,
> > > 
> > > On xfsporgs-dev v4.9.0 which has supported -d option, xfs_db command in
> > > xfs/288 still failed
> > > to set the header count of attr to 0. Is this issue casued by
> > > unsupported -d option on v5 XFS?
> > Hi,
> > 
> > I sent below patch yesterday:
> > https://marc.info/?l=linux-xfs&m=153287978423915&w=2
> > 
> > I should sent it with this patch together ... Is that OK after you
> > merge two patches?
> Hi Zorro,
> 
> Setting the header count of attr still got the following error even though we merged two patches:
> -----------------------------------------------------------------------
> Cannot recalculate CRCs on this type of object
> -----------------------------------------------------------------------
> 
> With -d option on V5 XFS, it seems that we cannot write attr and recalculate CRC before commit
> xfsprogs-dev 89baf91.  Maybe we also need to check if xfs_db can write attr and recalculate CRC.

Hi Xiao,

Looks like xfs_db write command hasn't supported to write attr blocks on
4.9 version (refer to xfsprogs commit 89baf918bf6092fa91d06c9e49a766fad31089d8,
and related patches. I didn't try it, but I think it's.)

So maybe I should check if xfs_db can write attr, not just check if it has
-d option :)

Thanks,
Zorro

> 
> Thanks,
> Xiao Yang
> 
> > Thanks,
> > Zorro
> > 
> > > Thanks,
> > > Xiao Yang
> > > 
> > > On 2018/07/30 15:42, Zorro Lang wrote:
> > > > Commit b3cf8b72334fd35ef961869506e5a72ab398bc82 help xfs/288 to
> > > > support v5 filesystems testing, but there're still some old
> > > > distributions don't support xfs_db 'write -d' usage. Then this
> > > > case fails on them.
> > > > 
> > > > For compatible with older versions, skip this test on v5 xfs
> > > > if xfs_db write command doesn't support -d option.
> > > > 
> > > > Signed-off-by: Zorro Lang<zlang@redhat.com>
> > > > ---
> > > >   tests/xfs/288 | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/tests/xfs/288 b/tests/xfs/288
> > > > index bccdb6fc..f8e117ed 100755
> > > > --- a/tests/xfs/288
> > > > +++ b/tests/xfs/288
> > > > @@ -40,6 +40,14 @@ _require_attrs
> > > >   _scratch_mkfs_xfs 2>/dev/null | _filter_mkfs 2>$tmp.mkfs>/dev/null
> > > >   . $tmp.mkfs
> > > > 
> > > > +# Require write -d option to write invalid data into V5 filesystem
> > > > +if [ $_fs_has_crcs -eq 1 ]; then
> > > > +	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)"
> > > > +	if [ $? -ne 0 ]; then
> > > > +		_notrun "xfs_db write doesn't support -d option"
> > > > +	fi
> > > > +fi
> > > > +
> > > >   _scratch_mount
> > > > 
> > > >   touch $SCRATCH_MNT/$seq.attrfile
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > .
> > 
> 
> 
> 

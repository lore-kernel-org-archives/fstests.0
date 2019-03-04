Received: from aserp2130.oracle.com ([141.146.126.79]:53468 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSMf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Mar 2019 13:12:35 -0500
Date: Mon, 4 Mar 2019 10:12:27 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 2/2] common/rc: add get_max_lfs_filesize to return
 MAX_LFS_FILESIZE
Message-ID: <20190304181227.GA6515@magnolia>
References: <20190226141154.142271-1-yuyufen@huawei.com>
 <20190226141154.142271-3-yuyufen@huawei.com>
 <20190302092341.GB2824@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302092341.GB2824@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Yufen Yu <yuyufen@huawei.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Mar 02, 2019 at 05:23:41PM +0800, Eryu Guan wrote:
> On Tue, Feb 26, 2019 at 10:11:54PM +0800, Yufen Yu wrote:
> > Pick up the common function get_max_lfs_filesize() to return
> > MAX_LFS_FILESIZE.
> > 
> > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > ---
> >  common/rc         | 16 ++++++++++++++++
> >  tests/generic/349 | 12 +-----------
> >  tests/generic/350 | 12 +-----------
> >  tests/generic/351 | 12 +-----------
> >  4 files changed, 19 insertions(+), 33 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 987f3e23..07883540 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3808,6 +3808,22 @@ get_max_file_size()
> >  	echo $l
> >  }
> >  
> > +# get MAX_LFS_FILESIZE
> > +get_max_lfs_filesize()

Somehow, this got committed upstream without the leading "_" in
common/rc, but generic/{349-351} do have it, which causes those tests to
regress.

I will send a patch with my weekly fixes rollup later this afternoon.

--D

> > +{
> > +	case "$(getconf LONG_BIT)" in
> > +	"32")
> > +       echo $(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> 
> Indenion problem here.
> 
> > +	       ;;
> > +	"64")
> > +	       echo 9223372036854775807
> 
> Mixing space and tab as indentions.
> 
> I'll fix them on commit.
> 
> Thanks,
> Eryu
> 
> > +	       ;;
> > +	*)
> > +	       _fail "sizeof(long) == $(getconf LONG_BIT)?"
> > +	       ;;
> > +	esac
> > +}
> > +
> >  # The maximum filesystem label length, /not/ including terminating NULL
> >  _label_get_max()
> >  {
> > diff --git a/tests/generic/349 b/tests/generic/349
> > index f01f817d..45d0619b 100755
> > --- a/tests/generic/349
> > +++ b/tests/generic/349
> > @@ -50,17 +50,7 @@ md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
> >  
> >  echo "Zero range to MAX_LFS_FILESIZE"
> >  # zod = MAX_LFS_FILESIZE
> > -case "$(getconf LONG_BIT)" in
> > -"32")
> > -	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> > -	;;
> > -"64")
> > -	zod=9223372036854775807
> > -	;;
> > -*)
> > -	_fail "sizeof(long) == $(getconf LONG_BIT)?"
> > -	;;
> > -esac
> > +zod=$(get_max_lfs_filesize)
> >  $XFS_IO_PROG -c "fzero -k 0 $zod" $dev
> >  
> >  echo "Check contents"
> > diff --git a/tests/generic/350 b/tests/generic/350
> > index 0aea4c09..a8f2939b 100755
> > --- a/tests/generic/350
> > +++ b/tests/generic/350
> > @@ -47,17 +47,7 @@ md5sum $dev | sed -e "s|$dev|SCSI_DEBUG_DEV|g"
> >  
> >  echo "Punch to MAX_LFS_FILESIZE"
> >  # zod = MAX_LFS_FILESIZE
> > -case "$(getconf LONG_BIT)" in
> > -"32")
> > -	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> > -	;;
> > -"64")
> > -	zod=9223372036854775807
> > -	;;
> > -*)
> > -	_fail "sizeof(long) == $(getconf LONG_BIT)?"
> > -	;;
> > -esac
> > +zod=$(get_max_lfs_filesize)
> >  $XFS_IO_PROG -c "fpunch 0 $zod" $dev
> >  
> >  echo "Check contents"
> > diff --git a/tests/generic/351 b/tests/generic/351
> > index e326dca1..c250bac4 100755
> > --- a/tests/generic/351
> > +++ b/tests/generic/351
> > @@ -62,17 +62,7 @@ $XFS_IO_PROG -c "fpunch 512 512" $dev
> >  
> >  echo "Zero range past MAX_LFS_FILESIZE keep size"
> >  # zod = MAX_LFS_FILESIZE
> > -case "$(getconf LONG_BIT)" in
> > -"32")
> > -	zod=$(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> > -	;;
> > -"64")
> > -	zod=9223372036854775807
> > -	;;
> > -*)
> > -	_fail "sizeof(long) == $(getconf LONG_BIT)?"
> > -	;;
> > -esac
> > +zod=$(get_max_lfs_filesize)
> >  $XFS_IO_PROG -c "fzero -k 512k $zod" $dev
> >  
> >  echo "Zero range past MAX_LFS_FILESIZE"
> > -- 
> > 2.16.2.dirty
> > 

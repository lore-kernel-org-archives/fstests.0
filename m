Received: from mail-pf1-f194.google.com ([209.85.210.194]:36605 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfBTNcp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Feb 2019 08:32:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so11934912pfa.3
        for <fstests@vger.kernel.org>; Wed, 20 Feb 2019 05:32:44 -0800 (PST)
Date: Wed, 20 Feb 2019 21:32:38 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/5] commom/rc: define function _get_max_file_size
Message-ID: <20190220133238.GB2713@desktop>
References: <20190220015955.26342-1-yuyufen@huawei.com>
 <20190220015955.26342-2-yuyufen@huawei.com>
 <20190220031206.GA672@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220031206.GA672@sol.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: Eric Biggers <ebiggers@kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 19, 2019 at 07:12:07PM -0800, Eric Biggers wrote:
> Hi Yufen,
> 
> On Wed, Feb 20, 2019 at 09:59:51AM +0800, Yufen Yu wrote:
> > Define a new function _get_max_file_size to return
> > the max file size supported by the special filesystem.
> > 
> > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > ---
> >  common/rc | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index e5da6484..10ab497d 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3785,6 +3785,29 @@ _require_scratch_feature()
> >  	esac
> >  }
> >  
> > +# get filesystem max file size
> > +_get_max_file_size()
> > +{
> > +	case $FSTYP in
> > +	vfat|jffs2|romfs)
> > +		echo $((2**32-1)) # 0xFFFFFFFF
> > +		;;
> > +	*) # MAX_LFS_FILESIZE
> > +		case "$(getconf LONG_BIT)" in
> > +		"32")
> > +			echo $(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> > +			;;
> > +		"64")
> > +			echo "9223372036854775807"
> > +			;;

I don't think this is correct. So ext4 always gets (8E-1) as the max
file size on 64bit system in this case, but it actually supports
(16T-4k) file if block size is 4k, and even smaller max file size when
block size is 2k or 1k.

This function is from generic/351, but that's for test against a block
dev not filesystem.

> > +		*)
> > +			_fail "sizeof(long) == $(getconf LONG_BIT)?"
> > +			;;
> > +		esac
> > +		;;
> > +	esac
> > +}
> 
> Why not move get_max_file_size() from tests/generic/485 to here instead?

Agree, the function in generic/485 would be better.

And I think the patchset should be in a single patch, which moves
get_max_file_size() function from generic/485 to common/rc and update
all related tests.

Thanks,
Eryu

> 
> - Eric

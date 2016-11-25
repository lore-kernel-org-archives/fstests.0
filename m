Received: from mout.kundenserver.de ([212.227.17.10]:62709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcKYMUn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Nov 2016 07:20:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] generic/390: Add tests for inode timestamp policy
Date: Fri, 25 Nov 2016 13:20:28 +0100
Message-ID: <7538941.tpP0Pki3Hl@wuerfel>
In-Reply-To: <20161124104055.GD4609@eguan.usersys.redhat.com>
References: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com> <20161124104055.GD4609@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, fstests@vger.kernel.org, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

On Thursday, November 24, 2016 6:40:55 PM CET Eryu Guan wrote:
> On Wed, Nov 23, 2016 at 04:52:02PM -0800, Deepa Dinamani wrote:
> > +_filesystem_timestamp_range()
> > +{
> > +	device=${1:-$TEST_DEV}
> > +	case $FSTYP in
> > +	ext4)	#dumpe2fs
> > +		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
> > +			echo "-2147483648 15032385535"
> > +		else
> > +			echo "-2147483648 2147483647"
> > +		fi
> 
> Do ext3 and ext2 follow the same config as ext4?

Those two only support the second case with 128 byte inodes, but the same
check should work on all three.

I have an overview of the limits on https://kernelnewbies.org/y2038/vfs,
though I'd probably check all of them again, as some of them turned out
to be wrong. In particular, identifying whether the on-disk timestamps
are meant to be signed or unsigned can be a matter of interpretation
and there may be a specification that disagrees with the implementation.

	Arnd

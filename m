Received: from mx2.suse.de ([195.135.220.15]:34670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729045AbfFFPc3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Jun 2019 11:32:29 -0400
Date: Thu, 6 Jun 2019 17:32:28 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH fstests v2] btrfs: add validation of compression options
 to btrfs/048
Message-ID: <20190606153228.GD4172@x250>
References: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
 <20190606113907.17551-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190606113907.17551-1-jthumshirn@suse.de>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>, Filipe Manana <fdmanana@gmail.com>
Cc: Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 06, 2019 at 01:39:07PM +0200, Johannes Thumshirn wrote:
[...]

> +echo -e "\nTesting argument validation with options"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo:9'

Please don't take this patch yet, setting lzo with a compression level sh=
ould
fail but doesn't. I'll be addressing this soon (and update the test
accordingly)

Thanks,
	Johannes
--=20
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

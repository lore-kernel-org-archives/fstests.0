Received: from mx2.suse.de ([195.135.220.15]:47486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbdDFSQC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Apr 2017 14:16:02 -0400
Date: Thu, 6 Apr 2017 20:15:56 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406181555.GA8215@linux-x5ow.site>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
 <20170406152000.GF3768@linux-x5ow.site>
 <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 06, 2017 at 10:32:43AM -0500, Eric Sandeen wrote:
> Full-blown xfstests doesn't have /that/ much in the way of deps,
> on debian it's ostensibly just:
>=20
>                 sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
>                 e2fsprogs automake gcc libuuid1 quota attr libattr1-dev=
 make \
>                 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio db=
ench \
>                 uuid-runtime
>=20
> and lots of that might not be needed for non-fs tests.
>=20
> Otherwise well, you do need bash ... ;)

Yeah that's OK. Maybe I misphrased it a bit. No more additional dependenc=
ies.
Currently xfstest is "small" engough to be run in an initrd and that's go=
od
for qemu -kernel .. -initrd .. style test runs.

Byte,
	Johannes

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

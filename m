Received: from mx2.suse.de ([195.135.220.15]:54412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfEPIJo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 May 2019 04:09:44 -0400
Date: Thu, 16 May 2019 10:09:42 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Message-ID: <20190516080942.GB3922@x250.microfocus.com>
References: <20190515150221.16647-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 15, 2019 at 04:02:21PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
Nit:
> This tes has found already 2 bugs in btrfs, that caused mtime and ctime=
 of
  test? ^

--=20
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

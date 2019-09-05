Received: from mx2.suse.de ([195.135.220.15]:37822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730937AbfIEQCE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Sep 2019 12:02:04 -0400
Subject: Re: [PATCH] btrfs/048: fix test failure when fs mounted with v2 space
 cache option
References: <20190905153700.21284-1-fdmanana@kernel.org>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <9d8a258a-76f1-68e7-f5c4-57b31fcc9846@suse.com>
Date: Thu, 5 Sep 2019 19:02:00 +0300
MIME-Version: 1.0
In-Reply-To: <20190905153700.21284-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 5.09.19 =D0=B3. 18:37 =D1=87., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> In order to check that the filesystem generation does not change after
> failure to set a property, the test expects a specific generation numbe=
r
> of 7 in its golden output. That currently works except when using the
> v2 space cache mount option (MOUNT_OPTIONS=3D"-o space_cache=3Dv2"), si=
nce
> the filesystem generation is 8 because creating a v2 space cache adds
> an additional transaction commit. So update the test to not hardcode
> specific generation numbers in its golden output and just output an
> unexpected message if the generation number changes.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

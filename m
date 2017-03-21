Received: from mx1.redhat.com ([209.132.183.28]:55302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755783AbdCUGQh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 02:16:37 -0400
Date: Tue, 21 Mar 2017 14:05:33 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 0/3] Btrfs in-band de-duplication test cases
Message-ID: <20170321060533.GS14226@eguan.usersys.redhat.com>
References: <20170316090851.21608-1-quwenruo@cn.fujitsu.com>
 <20170321045155.GR14226@eguan.usersys.redhat.com>
 <5a01bd29-d691-24e0-8c8f-3c5dc30370ca@cn.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a01bd29-d691-24e0-8c8f-3c5dc30370ca@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 01:22:33PM +0800, Qu Wenruo wrote:
>=20
>=20
> At 03/21/2017 12:51 PM, Eryu Guan wrote:
> > Hi Qu,
> >=20
> > On Thu, Mar 16, 2017 at 05:08:48PM +0800, Qu Wenruo wrote:
> > > Btrfs in-band de-duplication test cases for in-memory backend, which =
covers
> > > the bugs exposed during the development.
> >=20
> > Do you have a kernel tree that contains the in-band patches so that I
> > and others could try and run these tests?
>=20
> Of course.
>=20
> Kernel tree:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_adam900=
710_linux.git&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=
=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DYzsA7J_jQbbCdcg4s_RD-fVg=
AB-E0z9HI7TsNs0ISJ8&s=3D3WywXrgANPtqSESgw9Ey4wt8D3niq7n9yhn2W_lat1c&e=3D  w=
ang_dedupe_latest
>=20
> Btrfs-progs tree:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_adam900=
710_btrfs-2Dprogs.git&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057=
SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DYzsA7J_jQbbCdcg4s=
_RD-fVgAB-E0z9HI7TsNs0ISJ8&s=3D8wuw_b8hI8oTVNrb2E_N0mqv8jzV8svYD6gcotli0eY&=
e=3D  dedupe_20170306

Thanks! But I guess it's branch 'dedupe_20170316' of btrfs-progs repo,
right? There's no dedupe_20170306 branch.

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DYzsA7J_jQbbCdcg4s_RD-fVgAB-E0z9HI7TsNs0ISJ8&s=3Dr92jDqcAqEQ6yzfk0gRIezOr=
ZmWu-Nm5X5Rdo7mS0rM&e=3D=20

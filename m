Received: from cn.fujitsu.com ([59.151.112.132]:58874 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756330AbdCUFWk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 01:22:40 -0400
Subject: Re: [PATCH v2 0/3] Btrfs in-band de-duplication test cases
References: <20170316090851.21608-1-quwenruo@cn.fujitsu.com>
 <20170321045155.GR14226@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <5a01bd29-d691-24e0-8c8f-3c5dc30370ca@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 13:22:33 +0800
In-Reply-To: <20170321045155.GR14226@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 03/21/2017 12:51 PM, Eryu Guan wrote:
> Hi Qu,
>
> On Thu, Mar 16, 2017 at 05:08:48PM +0800, Qu Wenruo wrote:
>> Btrfs in-band de-duplication test cases for in-memory backend, which cov=
ers
>> the bugs exposed during the development.
>
> Do you have a kernel tree that contains the in-band patches so that I
> and others could try and run these tests?

Of course.

Kernel tree:
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_adam90071=
0_linux.git&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=3D=
-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DLH-PUN-NTCIEZi5d2XrvY6_JhnY=
PAgEaDvMo9hTzFyM&s=3DF2xbdCcGvb6crFhEcUtBrCPE8eGjCODlytD8HoBFOlA&e=3D  wang=
_dedupe_latest

Btrfs-progs tree:
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_adam90071=
0_btrfs-2Dprogs.git&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057Sb=
K10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=3DLH-PUN-NTCIEZi5d2Xr=
vY6_JhnYPAgEaDvMo9hTzFyM&s=3DO4LlYyQ_nT0wBVzWYlxn0aGYMO2SnljTsb1kxAoSifs&e=
=3D  dedupe_20170306

Thanks,
Qu
>
> Thanks,
> Eryu
>
>


--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwICaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DLH-PUN-NTCIEZi5d2XrvY6_JhnYPAgEaDvMo9hTzFyM&s=3D6szMktjYq6NMzo2R_IXGJkr1=
ABOyl7lW7zpeh8TRYmk&e=3D=20

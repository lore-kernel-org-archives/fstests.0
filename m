Received: from mx2.suse.de ([195.135.220.15]:41970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeKNQtE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Nov 2018 11:49:04 -0500
Subject: Re: Any method to limit page cache usage in test cases?
References: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <c066af76-261d-0628-c881-bed1b27dec92@suse.com>
Date: Wed, 14 Nov 2018 08:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 14.11.18 =D0=B3. 2:31 =D1=87., Qu Wenruo wrote:
> Hi,
>=20
> Is there any (easy) method for a fstests test case to limit the page
> cache usage?
>=20
> I triggered btrfs/139 failure with 2G vRAM VM, and located the root
> cause of the problem.

You can always size your test vm properly. Otherwise what about the
various sysctl tuning knobs? I.e Documentation/sysctl/vm.txt explains
some of them: dirty_bytes, dirty_background_bytes,
dirty_background_ratio, dirty_expire_centisecs


So with a 2g machine the default settings are using only a fraction of
the ram. If you adjust the same settings for the larger ram size you
should get almost identical behavior.



>=20
> However it's only really reproducible for small ram VM, since it could
> trigger dirty page writeback due to memory pressure.
>=20
> So I'm wondering if we could do such thing even for large RAM test mach=
ine.
>=20
> Thanks,
> Qu
>=20

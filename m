Received: from mail-pl1-f194.google.com ([209.85.214.194]:44628 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfDNCrw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 13 Apr 2019 22:47:52 -0400
Date: Sun, 14 Apr 2019 10:47:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/048: amend property validation cases
Message-ID: <20190414024745.GL2824@desktop>
References: <20190403165419.12666-1-anand.jain@oracle.com>
 <20190403170437.14448-1-anand.jain@oracle.com>
 <7de2d0fd-e777-2bec-5731-15ba2f2af4f2@suse.com>
 <20190406120207.GG2824@desktop>
 <20062818-d303-047c-358f-52ac9dad50de@oracle.com>
 <d552fff5-b43d-6dff-dbb2-3d236041df41@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d552fff5-b43d-6dff-dbb2-3d236041df41@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Apr 07, 2019 at 03:45:36PM +0300, Nikolay Borisov wrote:
>=20
>=20
> On 7.04.19 =D0=B3. 14:54 =D1=87., Anand Jain wrote:
> > On 6/4/19 8:02 pm, Eryu Guan wrote:
> >> On Fri, Apr 05, 2019 at 04:21:10PM +0300, Nikolay Borisov wrote:
> >>>
> >>>
> >>> On 3.04.19 =D0=B3. 20:04 =D1=87., Anand Jain wrote:
> >>>> Add more property validation cases which are fixed by the patches =
[1]
> >>>> =C2=A0 [1]
> >>>> =C2=A0=C2=A0 btrfs: fix vanished compression property after failed=
 set
> >>>> =C2=A0=C2=A0 btrfs: fix zstd compression parameter
> >>>>
> >>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>>
> >>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> >>
> >> Thanks for the test and the review!
> >>
> >> But this looks like a targeted regression test that may fail an exis=
ting
> >> test. It's better to write a new test for this.
> >=20
> > Regression is only when fstests is upgraded. This
> > test case mentions the prerequisite kernel patches [1].
> > So that should suffice the concern?
>=20
> I agree with Anand here, this is an extension to an existing test, whic=
h
> covers specific feature. IMO it's not good to always introduce new test=
s
> because every invocation of a test comes with an overhead of spawning
> processes and whatnot. THis is not a problem for 10 tests, but currentl=
y
> for btrfs we execute around 600 tests each one "wasting" some cycles to
> spawn bash processes to execute the actual test.

Fair enough. We're having more tests now, and we do consider "merging"
some tests into one case.

Thanks,
Eryu

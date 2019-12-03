Return-Path: <SRS0=DGTx=ZZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263ADC432C0
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EE02084B
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EWPBQK7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLCOOR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:14:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:56495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfLCOOQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Dec 2019 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575382427;
        bh=8IzOIidN/Lrk5pZZNPqZ7Gv2uNSWI5DWcDDZuXE3LwY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EWPBQK7fjy9KUur9ekGsrsjFDOHDX+2bosI8VRLkIanpRZwpk9CrU20R83AqO33Cv
         JkZixrtZuuEY+pvDInb7RNX7ZB6wmlvQxl/FPfLJvVTdkxeGE8oeP7vfH1i9w2TPPM
         khtvfiqU+tD6YdST38v6ltmJjC6jGOV8c2VJGtLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjjCL-1hwALp1LMB-00lEDh; Tue, 03
 Dec 2019 15:13:46 +0100
Subject: Re: [PATCH] xfs/148: sort and filter attribute list output
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
References: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191202232121.GD7339@magnolia>
 <297458b1-b8ad-3e88-e378-351faccc113b@cn.fujitsu.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <29508b62-5568-c745-ee84-9504d88e9404@gmx.com>
Date:   Tue, 3 Dec 2019 22:13:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <297458b1-b8ad-3e88-e378-351faccc113b@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fxhcj98RA66kZDt6Hfx4aDtVoE2rtWfoH"
X-Provags-ID: V03:K1:LqRpSI2ZGFB36YaQH7f7/0d9oQ5rikMGhFrnn3rAv96O7Ksn8wu
 nv1eokor8LKV79olfnLLRdv9IHS/xPGB9lYeUgIGtxkZieg8WMxXLM33iyExTty5eGe6igM
 Af5aOGJLYOWUMvOlk29Kp0YXnM7hPSus4zuiV6x8vxxx7EVl88gLIYTARLCQwTFPJbDFGLI
 F/NJu0ltqCJ5NTjI4itOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eyOOKOKC3y0=:1dfT5eXarf06r21uMevbf3
 KIcvt3s6eR5bzbIuZKCs3ObPVEu0HgfT08P6Mc5ALjrTDRdGF3uFflUcVIZXJc8ps49ZYh1qU
 bKjfTp9olBtaAz/6Rvy+lZw3+wHw72hFT89+HiR2XQGJ3dKrGCOLxo0asSVc8vWuO9Z6W54O0
 1ims5nryke9q4Mxg/pcvslN7xCWf0fVXjX5RJsHk1KDLPIdmWhLJ+dhOMC7e/+zx7mxKgv2Lg
 CIM8XkI6mzmwMhNDh5y2BWWCWDBEbtYFOkl9kGkM3GrmpJQ1zler1kjP6oVEu8yJRskle6rjC
 4NMWS1wo5XRDL4k+ciXX99snLfKeYJECGZwLnCeMxBatxy/fQfDnY7N1qMDliUznSmkAHPUve
 NoiRosOdJjuyYHyTMOs4k0C5iXO8rflwcr1x3IJrzHRDLTjQZh+UWMm7K72QUd5rvHC3uQoGf
 42BJKkSKkQOab8+OqeFq76DV49aDt9ecDa0zOSa71HIJIaJQ0hXfv50a+F1KW+jU9hwHthcEp
 fbE7/h0Hc/q+P8ToJ+xRJrdJ5AoksYrdCN9tojl/zmZPIiTJVFoU6lQTSAqwZhFsahyP85Qd/
 Tsa8EM4a+fzACmQer/M3wub8nqMT6fDDNPHUnvzP28x750VUSQ5Naj17ml32BnOmyJKI/uMJ0
 vA76f86iwAdwJopcFOVuCreggQ6f+RPRbBY/bBxvIqnW1YwStZZTdQaJDpXo46YE8dUhR5Jel
 bvsGL6X6SpiVNjZZuHKKsNhpD43vOq/rysxNSNgqe569+Jfyobp+sGqJ3NipeX9fugAx8nSq1
 Bg6sXzFR962KbnMb+t86dntnmiziiCSHhpy9F9Wc0TmSYUd02qp6z8R4+7+DscKO2H3I+lWtr
 m0NDyBjYqFA6u8Q8EGPOIChhNDfdX8xNpgs2L5DmqsatItxK46Diwf9WGyFmkmz4JLAuSPmcG
 764gmQXvX2OwZJddyton4iEftGDmo/qmsXIqUAGZ07F8FGTtfUCSYLFi00rRRme517gRy/LJN
 EINPxYc1XeHTHv2zNOG2EghX5aP8383AR3HrwpRc7nuDawYegPbJSKxqeQkWbNE7/oo4nYvPN
 RCDYXCp5rpkY/1DB/bSA/Vaq6A4aUsvQLk+cmKnGFqsgsJz7YMaY4ms+9WOcERLLtfeAST2JS
 +joRemvMmJBVQtwiJt/ZqISvxuKNtXMWPCH2D3TQcGJ0JvLiRzd9ScnVBLR93gutY1gY4nwVa
 RvGd8p6X+PQX/CqXDSZTfs94xkoutXC8wvWJg5LOq7IW2cz1xle2YgjflNtg=
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fxhcj98RA66kZDt6Hfx4aDtVoE2rtWfoH
Content-Type: multipart/mixed; boundary="Ah3nRrOmBier4yA7z46mmwn8wYF7Cswj5"

--Ah3nRrOmBier4yA7z46mmwn8wYF7Cswj5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/3 =E4=B8=8A=E5=8D=889:45, Yang Xu wrote:
>=20
>=20
> on 2019/12/03 7:21, Darrick J. Wong wrote:
>> On Thu, Nov 28, 2019 at 03:10:45PM +0800, Yang Xu wrote:
>>> When I backport fixed patches from Darrick tighten-verifiers tree,
>>> this case
>>
>> NAK, why are you backporting out of my development tree and not upstre=
am?
> My description is wrong. I use upstream kernel 5.4-rc8 and 4 attr
> patches as your tighten-verifiers tree do.
>> What are you even backporting, seeing as the patches for this are in 5=
=2E5
>> and Linus hasn't even pulled that yet??
>> I see Linus pulled the patches 3 hour ago,
>> Also, why are you sending a patch to fstests that is (a) barely a week=

>> old, (b) doesn't actually list me as the author, and (c) I myself
>> haven't even sent to fstests yet?
>>
> I=C2=A0 have listed you as author,

Just a tip, as it looks like Fujitsu CN guys are suffering from M$
Exchange mail server.

It looks like either you didn't apply the patch correctly or the mail
server (M$ Exchange if not changed) is modifying the "From: " line.

A properly formatted patch from another author looks like:

  From f82e569b33c3c1cfd4f8f405085ff8d439a0a915 Mon Sep 17 00:00:00 2001
  From: David Sterba <dsterba@suse.com>
  Date: Fri, 25 Oct 2019 14:05:38 +0200
  Subject: [PATCH] Btrfs progs v5.3.1

  Signed-off-by: David Sterba <dsterba@suse.com>
  ---

Note the "From: " line is the real author. A lot of mail servers don't
accept "From: " other than the sender.
And M$ Exchange is even worse, it will change "From: " tag to what M$
thinks is best.

E.g Patch sent through O365 with "From: Qu Wenruo <wqu@suse.com>" will
be modified to "From: Wenruo Qu <wqu@suse.com>", screwing up certain
patch accounting.

You'd better contact your IT department to solve the problem (if possible=
).

Thanks,
Qu

>=C2=A0 I think I should add=C2=A0 "Darrick J. Wong
> pointed=C2=A0 selinux and sort problem" info.=C2=A0 I find ls and
> "a_are_bad/for_you" problem.
> Also, in personal mail("Re: question about xfstests test case
> xfs/148(new)"), I said "I think you may=C2=A0 busy with other important=

> things. I will send this simple patch with correct "a_are_bad/for_you"
> info and add your signed-off-by tag."). Anyway, I am sorry, I should
> have received your reply before sending the patch.
>>> also fails. As below:
>>> -----------------------------------------------------------
>>> "diff test/xfs/148.out result/xfs/148.out.bad
>>> 7,8d6
>>> < Attribute "a_something" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> < Attribute "a_too_many_beans" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> 9a8
>>>> Attribute "a_too_many_beans" has a 3 byte value for
>>>> TEST_DIR/mount-148/testfile
>>> 10a10,11
>>>> Attribute "a_something" has a 3 byte value for
>>>> TEST_DIR/mount-148/testfile
>>>> Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testf=
ile
>>> 49,50c50,51
>>> < Attribute "a_are_bad/for_you" had a 3 byte value for
>>> TEST_DIR/mount-148/testfile:
>>> < heh
>>>> attr_get: No data available
>>>> Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
>>> -------------------------------------------------------------
>>> We should sort attribute list output and filter selinux. Also
>>> "a_are_bad/for_you"
>>> doesn't exist, we should correct it in output.
>>>
>>> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ...
>>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>> =C2=A0 tests/xfs/148=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 tests/xfs/148.out | 8 ++++----
>>> =C2=A0 2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tests/xfs/148 b/tests/xfs/148
>>> index 42cfdab0..06862faa 100755
>>> --- a/tests/xfs/148
>>> +++ b/tests/xfs/148
>>> @@ -76,7 +76,7 @@ test_names+=3D("too_many" "are_bad/for_you")
>>> =C2=A0 =C2=A0 access_stuff() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ls $testdir
>>> -=C2=A0=C2=A0=C2=A0 $ATTR_PROG -l $testfile
>>> +=C2=A0=C2=A0=C2=A0 $ATTR_PROG -l $testfile | grep "a_" | sort
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for name in "${test_names[@]}";=
 do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ls "$testdir/f=
_$name"
>>> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
>>> index c301ecb6..ab3fc25b 100644
>>> --- a/tests/xfs/148.out
>>> +++ b/tests/xfs/148.out
>>> @@ -4,10 +4,10 @@ f_another
>>> =C2=A0 f_are_bad_for_you
>>> =C2=A0 f_something
>>> =C2=A0 f_too_many_beans
>>> +Attribute "a_another" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> +Attribute "a_are_bad_for_you" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> =C2=A0 Attribute "a_something" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> =C2=A0 Attribute "a_too_many_beans" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> -Attribute "a_are_bad_for_you" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> -Attribute "a_another" has a 3 byte value for
>>> TEST_DIR/mount-148/testfile
>>> =C2=A0 TEST_DIR/mount-148/testdir/f_something
>>> =C2=A0 Attribute "a_something" had a 3 byte value for
>>> TEST_DIR/mount-148/testfile:
>>> =C2=A0 heh
>>> @@ -46,5 +46,5 @@ ls: cannot access
>>> 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
>>> =C2=A0 attr_get: No data available
>>> =C2=A0 Could not get "a_too_many" for TEST_DIR/mount-148/testfile
>>> =C2=A0 ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_yo=
u':
>>> No such file or directory
>>> -Attribute "a_are_bad/for_you" had a 3 byte value for
>>> TEST_DIR/mount-148/testfile:
>>> -heh
>>> +attr_get: No data available
>>> +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
>>
>> Huh?=C2=A0 Why???
>>
>> NAK NAK NAK
> a_are_bad_for_you has been corrupted by "/". So it should be nothing
> such as=C2=A0 a_too_many_beans by beans. am=C2=A0 I wrong?( I use 5.4-r=
c8 and 4
> patches
> xfs: check attribute leaf block structure
> xfs: namecheck attribute names before listing them
> xfs: namecheck directory entry names before listing them
> xfs: replace -EIO with -EFSCORRUPTED for corrupt metadata
> ,this four patches from
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/co=
mmit/?h=3Dtighten-verifiers
>=20
> )>
>>
>> --D
>>
>>> --=C2=A0
>>> 2.18.0
>>>
>>>
>>>
>>
>>
>=20
>=20


--Ah3nRrOmBier4yA7z46mmwn8wYF7Cswj5--

--Fxhcj98RA66kZDt6Hfx4aDtVoE2rtWfoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3mbZcACgkQwj2R86El
/qh2pgf/SkCijn9ac4D0sU8T14URWyY5HCiX9AKCc7xGM3UsJ/nER81sySHM/dSF
r5yrMKK44z275tCrlwQJICBFLTL8Icvo0KlX9AjrU20B6G32ELqyT98qGDd6SBru
nqu3WZ2wlmUV0fU6b5qp1fQrlRuxAnhDxfmhhw4yunxbgUZGsDYWkTTJVGrvlRwJ
nKQe754AFVQPK0PBFZqGHLH99NJwbS+cPdHw+vUpwd8HY7HKd/4ati9NhQP9iTUn
iVqs5DsT54LQ69ruvrF6rddTc2tpUpVT4H1Vjuf/aszVvJGsWCviUq2EYl66wsO7
aq/n7sbNbR2shZL9f4JSlyW6EGBUMw==
=ebJs
-----END PGP SIGNATURE-----

--Fxhcj98RA66kZDt6Hfx4aDtVoE2rtWfoH--

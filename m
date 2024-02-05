Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061D168BC
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128412; cv=none; b=j7AOjr6S66TBKbYl1t872IvMW49YRXCSxTiKla1Qg+zy4AE+eVImPl2usXVrwsL5QQX+EXE25Z0v1RhwNtAOlADp5UgiT3B3kLEAARkewAfweZMnA9b+ncguCdKFsIaGFjoS9yfi3p/a/ZK9Fxo4Rs9HXGEC412Iq2p0vLeFOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128412; c=relaxed/simple;
	bh=W8dtk/ZfJxIciXcF5AlukCQc7upicpTsU5u9EryhCC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBzp7bR0+LqLxVpuJyfYdRTEAeTSrCe6Jz0/br7BjgWUpz7/IxV0S+96WFMIXWo7xZbliiaZ4qym8GxOd4ko4AO8FpJOTkaL3MHcEnZO5AeIQhAoOjK9DCADEqtwxzF52grY2EX3IVkWu70O+8p1M8Xk5CV8jjhlGfjZI8UmEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0ZpOKlh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ZpOKlh"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6de8a699dso3542227276.3
        for <fstests@vger.kernel.org>; Mon, 05 Feb 2024 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707128409; x=1707733209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B/1RGrzSE9AJz8jGcBCjeQb3xtzTlyR6MqQOaTtCeE=;
        b=T0ZpOKlhld5pFf2J4r/Uo8zG9pLRVDyRjd9j1W8RyDOkaxFlU73JK5soOkqjOgDWXq
         AkhXnmbVZY5vKFFGZqqO8r1HbxwamzlIkH8+h8u21FsAm9liOLHcWrv8GVUPHc7br65C
         JBl60C24XmpTo/+3hi3BYlS9XMZSyHs1kS80kovjQqfJTdWHz1sMNQQh7zjvY5yrBU5t
         3cESH2Z+sPMzvCFDqjE4SYdSE9PdieL1AjRRU8CKz76bfm2QA5aKvG3EpSkI4ZzT8S49
         Arng6Nu/PicXEJtgANDieACUbGPqTYH688RZZ9EyVFUitl0rcRkVCwkc2931XyX2LfaH
         dlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128409; x=1707733209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B/1RGrzSE9AJz8jGcBCjeQb3xtzTlyR6MqQOaTtCeE=;
        b=MYLBnhsBuatfkHmf4sMaQN+CDxHA0LUJkcmVVYKuWU/JiM+queuUGQSkIQhm+ujAuj
         Cm49MrZvMFnrTcwyMMVg6lnDtix6jVGaRveEgE4CdLEl7DgCNuwYQLtk9xVI78xuegsl
         gxxDzVyljvOipxTDJqNbPBKg7lc96iqRlwXy+rUS5gJ0qmPZ6nsCCuGzXrmq5xn/Qs1d
         IZCA2QqO7vdyH6SdN6BMPRZL0ojcYmAOzLDrMf+8vdLTS0Hdkwkxuuv5AwZDEO3n9/1Q
         gp57rGy7cnGTfaRrQ09K27ysWTtUoQ784jSdoYs2jlKmP2Yzw+oe28hr11/3WAtHkDa1
         6+fg==
X-Gm-Message-State: AOJu0YwKYNjYVzdR0Fl8zGavCWkRn0AtdOHD6eq9TZvuHz/j32tiSUXN
	IFAbxSDnjxbaYohLEaV3F1xpWufMle1gP3QcVnKO9Trg10lJGkMkcVqHF7A1vVRd0x1H7oyPgtf
	2Arlq4eHj16t3pW46iByGgyyWSjxeh/Zut1E=
X-Google-Smtp-Source: AGHT+IEYfrkFCx5OxPuw0lv/m8ZYm8MG0WqtN7WmVdLvU1aNy4xVqLoxa+38yzuV5jNvvbfFaDqBXhhq5kSdutbHToE=
X-Received: by 2002:a25:2fc2:0:b0:dc6:c669:9914 with SMTP id
 v185-20020a252fc2000000b00dc6c6699914mr12162868ybv.15.1707128409146; Mon, 05
 Feb 2024 02:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65bfa42f.050a0220.ab271.eb3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240205054502.rsc5rnkkifpr3hn6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205061626.mve2cp5btbpiijgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240205065642.3hqhipmnxkg442kg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240205065642.3hqhipmnxkg442kg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 5 Feb 2024 12:19:57 +0200
Message-ID: <CAOQ4uxiJRkSzOFEDpSC25R2wh8A_v-JSB4h=W3OB6NvihOdMbA@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.02.04
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:56=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:16:26PM +0800, Zorro Lang wrote:
> > On Mon, Feb 05, 2024 at 02:00:16PM +0800, Zorro Lang wrote:
> > > On Mon, Feb 05, 2024 at 01:45:02PM +0800, Zorro Lang wrote:
> > > > On Sun, Feb 04, 2024 at 10:48:47PM +0800, Zorro Lang wrote:
> > > > > Hi all,
> > > > >
> > > > > The for-next branch of the xfstests repository at:
> > > > >
> > > > >         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > > > >
> > > > > has just been updated and tagged as v2024.02.04 release.
> > > > >
> > > > > Release Notes:
> > > > > 1) There's 4 new test cases in this release -- btrfs/310, generic=
/740, xfs/601,
> > > > >    and xfs/606.
> > > > > 2) btrfs/303 is removed.
> > > > > 3) Supports XFS metadump V1 and V2 testing, refer to common/xfs_m=
etadump_tests
> > > > >    new file (might be renamed to common/metadump if more other fs=
 need).
> > > > > 4) Some fixes and updates for UBIFS, BCACHEFS and NFS testing, we=
lcome more
> > > > >    updates for more filesystems.
> > > > > 5) Some updates/fixes for source building, if anyone find buildin=
g issues in
> > > > >    this release, please report to us.
> > > > >
> > > > > More details refer to below, thanks for all your contributions!
> > > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > > The new head of the for-next branch is commit:
> > > > >
> > > > > 9b63adb69add t_snapshot_deleted_subvolume: add check for BTRFS_IO=
C_SNAP_DESTROY_V2
> > > > >
> > > > > New commits ([N]ew, [U]pdate, [D]elete):
> > > > >
> > > > > Alexander Aring (1):
> > > > > [N]      [56625c897fd9] generic: add fcntl lock corner cases test=
s
> > > > >
> > > > > Anthony Iliopoulos (2):
> > > > > [U]      [42f3cb7e56e3] src/af_unix: drop unused offsetof macro d=
efinition
> > > > > [U]      [79d98d94e58c] build: remove unused m4 macros
> > > > >
> > > > > Boris Burkov (1):
> > > > > [D]      [a6e196af46cc] btrfs: Remove btrfs/303
> > > > >
> > > > > Darrick J. Wong (10):
> > > > > [U]      [e7eadc3ee835] generic/256: constrain runtime with TIME_=
FACTOR
> > > > > [U]      [8c8be04c1065] common/xfs: simplify maximum metadump for=
mat detection
> > > > > [U]      [42f797643529] common/populate: always metadump full met=
adata blocks
> > > > > [U]      [56ccc8cc69d1] xfs/336: fix omitted -a and -o in metadum=
p call
> > > > > [N]      [85c1e0f518ff] common: refactor metadump v1 and v2 tests
> > > > > [U]      [1bdc3a5f1c9a] xfs/{129,234,253,605}: disable metadump v=
1 testing with external devices
> > > > > [U]      [329671426287] xfs/503: test metadump obfuscation, not p=
rogressbars
> > > > > [N]      [c31a500edc04] xfs/503: split copy and metadump into two=
 tests
> > > > > [U]      [7e2bf5955c2d] common/xfs: only pass -l in _xfs_mdrestor=
e for v2 metadumps
> > > > > [U]      [6f4223b6865f] xfs/122: fix for xfs_attr_shortform remov=
al in 6.8
> > > >
> > > > Note: A regression problem on this release sometimes after running =
xfs/605 or
> > > > xfs/129, it only affect XFS testing, it might kill all later testin=
g, I'm
> > > > looking into it, and fix ASAP, please linux-xfs don't not update to=
 this
> > > > release temporarily, wait for a fix. Sorry for this trouble.
> > >
> > > !!! It's a critical dangerous bug! Please don't use this release on x=
fs testing, it might
> > > kill your system!
> > >
> > > The problem comes from common/xfs_metadump_tests:_cleanup_verify_meta=
dump():
> > >
> > >    rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
> > >
> > > The XFS_METADUMP_FILE and XFS_METADUMP_IMG are set in _setup_verify_m=
etadump(), but
> > > if the _setup_verify_metadump isn't called due to someone case _notru=
n before calling
> > > it, its _cleanup will still do _cleanup_verify_metadump, likes this:
> > >
> > >   _cleanup()
> > >   {
> > >         cd /
> > >         rm -r -f $tmp.*
> > >         _cleanup_verify_metadump
> > >
> > > Then boooomb, it does "rm -f *" in "/" .... The "*" after "rm" must b=
e written
> > > carefully. I'll send a patch to fix this problem soon, please don't u=
pdate
> > > fstests until the fix be merged.
> >
> > I decide to make a respin, I think this bug is dangerous enough due to =
it might kill
> > the whole testing system. If someone use fstests without the fix, that'=
s too dangerous.
> >
> > I think most of people haven't shifted to the new release, and this ver=
sion hasn't
> > been merged into master branch. So I decide to do a respin with a manua=
lly fix to
> > avoid this problem ASAP. Then we can do more jobs later. Sorry for this=
 trouble,
> > hope it hasn't affected you.
>
> I've reset the for-next branch to last v2024.01.14 version. Please don't =
worry, the
> patches already got RVBs are in my local branch, I'll make a new release =
in this
> week soon, after some discussion and testing.
>

Would you consider including my ovl test fix in this release:
https://lore.kernel.org/fstests/20240203081228.1725872-1-amir73il@gmail.com=
/

Without this fix, overlay/084 fails on master and on v.6.7.3.

Thanks,
Amir.

Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55262BE629
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696660; cv=none; b=rxVrPnJAlSK2b4ed3tyFfq9632P1zb0Bv65k/+FwX/ECvrHx7wcjdiqtVSTEqwobCShhre/zYY/EGBaGF9Hb3Kj1Zy8RhTw476OiFwDMMm+xjafWB3/3SV743qZHEoSJQEPiMVeCpCXYNxkGmaHTxx8nbapaPw8pDj4GVOuSquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696660; c=relaxed/simple;
	bh=RDWUJ6AO/ZJyudnKrNlaISNlzRpYq9lNdxLJcE17zhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmrgxNM+rauv3EGg7kpUrGB+CUCPuA7xTFH1E967cz/Q0NYqFafuIb9qPqzpuJfIItm9DVtfU/avRlL45w6VJBeAzfUjtqDHmtmbhPeEFldeUjB/bhcyhqFZENiQSW+OEMh+AnLdAw3QKUX/yiRcmShJ/4ISZ9udDi5Gxkv0pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHIkPejx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHIkPejx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so8956039a12.0
        for <fstests@vger.kernel.org>; Tue, 02 Dec 2025 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696656; x=1765301456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmsw0LHfH3ZUj43PbQyiEazpGum6IBorGsIrkNt3xK8=;
        b=cHIkPejxcQ+vqr1IfTOBkHo02tDsDRl1ZpPozwGj+8IYNufmSBXLXUiSTuhO6/eis4
         C5eZDK509yXw9BdnSyQmw0EtWcXKd4v3Xf5zVi6eWlWQYfmLg6q8pzqP4eQYpCjH95ym
         96KBb0oS4R/qw9LjCrgRbVTlNPV0D0cYHIHm+srhMLIk8ds9FxTk4ZMvBCXGR5EK9w0b
         ojmnqPnUoimkm+HuB6p3jYdxBAayorDIhQ2d2zzxpn4rsyF3VHAnhz+6MMG7JcjPEdNJ
         /55OPhGV3CixG0wKP5nqdkqrMWhxGPvmnc4h5JU6QknxA41OaufHnz8k64Ef1q6jGCxI
         VT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696656; x=1765301456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hmsw0LHfH3ZUj43PbQyiEazpGum6IBorGsIrkNt3xK8=;
        b=jC4lQavSvX4JSgfdIuFk91Xyl0sb4d9/RJAppLjdFKV98Quh+nULCtDmhOHb9Xz1ZI
         hxmNvfXzRCY3w/7toT8PQ81y1Y/aS4hBora//nFXh4xeLzoDrlf5+c/O+0b/fnLjFSOR
         6kK+Zy+pv7y+zuY3Imklx//tK5rXxnaK8Wnp1Itmam/MY3k0G3aimngKQOXSHYH3S3M0
         wdC0Kn0c90n440CAI58UTXpOOrlNpCnGa0GuqVaUCy8EpAT78qqaSOmBuan8/8+aRfM/
         I010wI4H226+nynsWdy+mixLwPXOtCtSiAFJWQ2s0EP2PEnUwM+p0EV1GSUfFNqzsJb8
         K0tA==
X-Forwarded-Encrypted: i=1; AJvYcCWAtfj72SUpE7FdtpcJ9OnhO1Yuo9TC4nQ0gTTuP+c0FzG2R6oMgksT0TiZqfybEsCxojhJL1I5@vger.kernel.org
X-Gm-Message-State: AOJu0YxTF7MO78S2qoNsW9KOj20fu2Zs8oGULSxi3E1LCySO76awz/tM
	m0YhWfeZ3Z48ARnZZgYq/eN162mvMy319hAB5IOAm8/D5Pb4Eebk45bVOT8K8UTYHgvmUBeCndF
	tgjQLFNjeSVQd4sOjcHcdAROlFGviioY3mg==
X-Gm-Gg: ASbGncvub3bNPPM2Sv5S5d5Sdh8J1Tml+1kPkDTUIVCqCSReDkOau6mwJC4grdPuTQV
	rj8swPSpzaT484Xfay4deFEsoJMeN9idIadJCfeT3O+d84xeHzRYozcIg+rhfo7iFmNc2qP5Pv3
	rF376BXVRZwHAJYG2xEgWxW14YaQPH5a461NH3ZjkZJZtfEXK39BATXOtmQSgFSk2VkKwPTbz38
	Ebzw3bJUX03FwXsM9K22/R1TBLWZ7F2rMp2KWF4MvSBjaFBZZRXigfOuUekC/D/T6UZc75M59SL
	+Yn65C/4kp3T4dbqWz50uO01Bw==
X-Google-Smtp-Source: AGHT+IEfdvX1jsrIATEgtlH78D+rzaVYSet9VkzrPPTVLAQqnFhRTtL+xptap3ekQTad3zFq2+Gn0P5RMx8hqNf65ow=
X-Received: by 2002:a17:907:7ba1:b0:b73:6b24:14a0 with SMTP id
 a640c23a62f3a-b76c53c09a2mr3696810666b.18.1764696655853; Tue, 02 Dec 2025
 09:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043952.GA70808@macsyma.lan>
In-Reply-To: <20251202043952.GA70808@macsyma.lan>
From: Jaegeuk Kim <jaegeuk.kim@gmail.com>
Date: Tue, 2 Dec 2025 09:30:44 -0800
X-Gm-Features: AWmQ_bne6r1y_X2bRM8K6dalS0d4KRJvwxsijCee69AflNuvS_RrQ4uLLqRIWgw
Message-ID: <CAOtxgyeik6kgF6SktvFj=anntmJZ_aWneqq1XzLpqpHK1XMb+Q@mail.gmail.com>
Subject: Re: generic/204 is crashing on linux-next when testing f2fs
To: Theodore Tso <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 8:40=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
>
> (fstests cc'ed so I can a get handy-dandy lore.kernel.org URL for the
>  exclude file with the background for the test exclusion.)
>
> Hi, I've been running xfstests on ext4, xfs, btrfs, and f2fs on
> linux-next[1], and for the past week or two, the tests have been
> hanging due to a BUG getting triggered on either f2fs/encrypt[2] or
> f2fs/compress[3] test configrations.
>
> [1] Using the command: "gce-xfstests ltm -c ext4/all,xfs/all,btrfs/all,f2=
fs/all -g auto --repo https://kernel.googlesource.com/pub/scm/linux/kernel/=
git/next/linux-next --watch fs-next"
> [2] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/file=
s/root/fs/f2fs/cfg/encrypt
> [3] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/file=
s/root/fs/f2fs/cfg/compress
>
> Interestingly, after the BUG_ON things get wedged so badly that
> "systemctl" hangs forever.  So apparently whatever is going wrong, it
> causes the systemd to malfunction in a profound way.  As a result, the
> test VM hangs for days until I get around to aborting the VM.
>
> For now, I'll exclude generic/204 from the f2fs configs in my test
> appliance; if you have a chance to take a look at this and let me know
> when it might be safe to re-neable generic/204 for f2fs, that would be
> great.  Thanks!

Thank you for sharing the report. I didn't hit this in my setup tho, let
us try to reproduce it first.

>
> BTW, if you'd be interestedr receiving the daily ouptut of the
> gce-xfstests run for f2fs, let me know.  That can be arranged...
>
>                                   - Ted
>
> P.S.  Here's the dmesg output from a run this morning using the
> linux-next kernel 6.18.0-xfstests-g781b8d22e5d5:
>
> [ 1011.282502] run fstests generic/204 at 2025-12-01 22:27:28
> [ 1011.604590] F2FS-fs (dm-1): f2fs_recover_fsync_data: recovery fsync da=
ta, check_only: 0
> [ 1011.605016] F2FS-fs (dm-1): Mounted with checkpoint version =3D 55cbed=
75
> [ 1065.186351] ------------[ cut here ]------------
> [ 1065.191112] kernel BUG at fs/f2fs/segment.c:2872!
> [ 1065.195977] Oops: invalid opcode: 0000 [#1] SMP PTI
> [ 1065.201170] CPU: 0 UID: 0 PID: 390275 Comm: umount Tainted: G        W=
           6.18.0-xfstests-g781b8d22e5d5 #1 PREEMPT(none)
> [ 1065.212886] Tainted: [W]=3DWARN
> [ 1065.216868] Hardware name: Google Google Compute Engine/Google Compute=
 Engine, BIOS Google 10/02/2025
> [ 1065.226646] RIP: 0010:get_new_segment+0x28d/0x2b0
> [ 1065.231684] Code: e4 ff ff ff e9 5f ff ff ff ba 08 00 00 00 31 f6 4c 8=
9 e7 e8 25 14 fe ff 4c 89 ef e8 6d ea 6c 00 b8 8b ff ff ff e9 3e ff ff ff <=
0f> 0b 83 7c 24 04 01 0f 85 4e fe ff ff 41 39 ee 0f 82 45 fe ff ff
> [ 1065.250635] RSP: 0018:ffffb3d684a2b860 EFLAGS: 00010246
> [ 1065.255988] RAX: 0000000000000031 RBX: ffffb3d684a2b8b4 RCX: 000000000=
0000031
> [ 1065.263230] RDX: 0000000000000000 RSI: 0000000000000031 RDI: ffff8e76c=
1d3e290
> [ 1065.270556] RBP: 0000000000000001 R08: ffff8e76c1d3e288 R09: 000000000=
0000000
> [ 1065.277801] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e76c=
6b1f000
> [ 1065.285090] R13: ffff8e7729c2308c R14: 0000000000000000 R15: ffff8e772=
9c23080
> [ 1065.292362] FS:  00007fb977a5f840(0000) GS:ffff8e78090e8000(0000) knlG=
S:0000000000000000
> [ 1065.301096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1065.307080] CR2: 00007fef85ee165c CR3: 000000015b64e006 CR4: 000000000=
03706f0
> [ 1065.314528] Call Trace:
> [ 1065.317324]  <TASK>
> [ 1065.319547]  new_curseg+0xb5/0x220
> [ 1065.323166]  f2fs_allocate_data_block+0x51e/0x750
> [ 1065.328026]  do_write_page+0x57/0x280
> [ 1065.331823]  f2fs_do_write_node_page+0x38/0x70
> [ 1065.336395]  __write_node_folio+0x2d1/0x4e0
> [ 1065.340723]  f2fs_sync_node_pages+0x428/0x550
> [ 1065.345209]  block_operations+0x33e/0x450
> [ 1065.349518]  f2fs_write_checkpoint+0x103/0x5e0
> [ 1065.354119]  kill_f2fs_super+0x14b/0x190
> [ 1065.358297]  deactivate_locked_super+0x33/0xb0
> [ 1065.362918]  cleanup_mnt+0xea/0x180
> [ 1065.366582]  task_work_run+0x5c/0xa0
> [ 1065.370323]  exit_to_user_mode_loop+0xb1/0xd0
> [ 1065.374850]  do_syscall_64+0x155/0x160
> [ 1065.378830]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1065.384054] RIP: 0033:0x7fb977cb8217
> [ 1065.387743] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 0=
0 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 5b 0d 00 f7 d8 64 89 02 b8
> [ 1065.406622] RSP: 002b:00007ffc531c8d48 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a6
> [ 1065.414317] RAX: 0000000000000000 RBX: 0000564b0abc7af8 RCX: 00007fb97=
7cb8217
> [ 1065.421570] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000564b0=
abce710
> [ 1065.428834] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1065.436085] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fb97=
7e1826c
> [ 1065.443415] R13: 0000564b0abce710 R14: 0000564b0abc7e30 R15: 0000564b0=
abc79f0
> [ 1065.450667]  </TASK>
> [ 1065.453067] ---[ end trace 0000000000000000 ]---
> [ 1065.457915] RIP: 0010:get_new_segment+0x28d/0x2b0
> [ 1065.462751] Code: e4 ff ff ff e9 5f ff ff ff ba 08 00 00 00 31 f6 4c 8=
9 e7 e8 25 14 fe ff 4c 89 ef e8 6d ea 6c 00 b8 8b ff ff ff e9 3e ff ff ff <=
0f> 0b 83 7c 24 04 01 0f 85 4e fe ff ff 41 39 ee 0f 82 45 fe ff ff
> [ 1065.481788] RSP: 0018:ffffb3d684a2b860 EFLAGS: 00010246
> [ 1065.487199] RAX: 0000000000000031 RBX: ffffb3d684a2b8b4 RCX: 000000000=
0000031
> [ 1065.494559] RDX: 0000000000000000 RSI: 0000000000000031 RDI: ffff8e76c=
1d3e290
> [ 1065.501898] RBP: 0000000000000001 R08: ffff8e76c1d3e288 R09: 000000000=
0000000
> [ 1065.509183] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e76c=
6b1f000
> [ 1065.516459] R13: ffff8e7729c2308c R14: 0000000000000000 R15: ffff8e772=
9c23080
> [ 1065.523744] FS:  00007fb977a5f840(0000) GS:ffff8e78090e8000(0000) knlG=
S:0000000000000000
> [ 1065.532160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1065.538091] CR2: 00007fef85ee165c CR3: 000000015b64e006 CR4: 000000000=
03706f0
> [ 1065.545412] note: umount[390275] exited with preempt_count 1
>
>

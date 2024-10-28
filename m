Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF191E48A
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121170; cv=none; b=DzHP6ThrFBC70FvZ6I3bgzjMcwVAgZyEGhbWlg+nt1u1vqc74u+le4hQkRMrFbHc3uAkHN2xRyeUb1TGf6G6nUqfimT4fqNRO8/IaS81Tc6hiSpkplkO45Fa5iv719V1skP2pbBpNVCEg3GbMtkbecoRXKWilNfM85rYUou7llY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121170; c=relaxed/simple;
	bh=PVcU07qNXqqmE1rAY/ijTmWLXl6xI1ShtLQcgmKPjR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqa4xTIZ7YcKBli0wz052qhFWedfgRN4W8e1jZCEV33eJNnTw2ZEscN4J/Je0xq/eYbhq04+9gbdLdXfBEZX0SZX0VhBtjPj4skQe91gH1wMreAjsH/tWftmayGdSdjX8vN6yBYEP0GAP1qW3bxBjqgNTwrBmmnhLU0pehEFrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzcSj7MY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzcSj7MY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730121165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OG6L0HHmYXCXXbcsZcV7jlgYKEqfbnBuVDrHhwhiyeI=;
	b=KzcSj7MYYC0DkxU/wqlAAW5MEjMi9rTnVjd/gyXgk+JeOPK1QMRbW6ICXNNmtyMo/I2o9l
	HhnAWD0Q/uQXL5gYbuGQUnv8OkEp+Rvjnimca/spFbXRy1/129NpS9XTyy0LJFTfH1uyRs
	RhJyd5oqiNLo/J4xSxaNyt50IwHf0sw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-dKmtSoB3MzGEdP8_DITr_Q-1; Mon, 28 Oct 2024 09:12:44 -0400
X-MC-Unique: dKmtSoB3MzGEdP8_DITr_Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e51a31988so6120972b3a.1
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 06:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121163; x=1730725963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OG6L0HHmYXCXXbcsZcV7jlgYKEqfbnBuVDrHhwhiyeI=;
        b=tyCn/vOkuETfrWEM3iSK50CYs+BeyT9Ty5tRPlBbW8XkFMpu8fE8YYkLXOBTP+j6NM
         23ds3X7k6vAjHfkduRBoG3FVykWs+yqPbC2UNj+tH6mWnBDHR95IQ7tRYdrze1FTz6yN
         FMLu5ZKYRHw/pgTBgQF0wrRZ9g/iW1CqxSArjBtQfQWw0RfghQU7miqgGuza7PTEm8zq
         D9duqt2HgFzzKN+NYAPBi0qM6+KVxMb09jslP6RsVs+sBjNkATOmbAPcrDzZN3SQg/T+
         J/auHZnvHcw0QSb+Rivzr9qK1McWoDvUOWee4K4VNQ+CtIIk/hP6u04kLzNPLc2i40nK
         gHYA==
X-Gm-Message-State: AOJu0YypAxdiROtpJ2CtV3jbNccaDhfZnVIjkVTDwsLHCKwPXgPg4Rk1
	Clr6od6lRVAyXhtezKYObALX3Fzi76BIQQkJLOUIr321Y0A8ivLFRMJR4cEPE02t9YQ8/TBfSrH
	f6jFZ34HP52oVpkRqBYFZtTWOsLye0NRhTK/IvVSNsq2R95i9qLh8/3Dqi2ad2lGayA==
X-Received: by 2002:a05:6a00:4fc3:b0:71e:410:4764 with SMTP id d2e1a72fcca58-72062f83b02mr13223388b3a.8.1730121162927;
        Mon, 28 Oct 2024 06:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG81o9K3QfigAYSj/5m3ZN6iYeFrkcxG7PhZ158eWLEnV0cCrWOFyz2XkstVzJ8ZXRj7kdqhA==
X-Received: by 2002:a05:6a00:4fc3:b0:71e:410:4764 with SMTP id d2e1a72fcca58-72062f83b02mr13223341b3a.8.1730121162391;
        Mon, 28 Oct 2024 06:12:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm5663110b3a.101.2024.10.28.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:12:42 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:12:38 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs/006: add testcase to check out-of-space case
Message-ID: <20241028131238.qvd7el4cz44edjut@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241023081602.3806579-1-chao@kernel.org>
 <20241025034413.5s6ecilfgqcoeudt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <53cb9bde-d845-49d6-858e-147b0870fbbf@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <53cb9bde-d845-49d6-858e-147b0870fbbf@kernel.org>

On Mon, Oct 28, 2024 at 05:47:06PM +0800, Chao Yu wrote:
> On 2024/10/25 11:44, Zorro Lang wrote:
> > On Wed, Oct 23, 2024 at 04:16:01PM +0800, Chao Yu wrote:
> > > This is a regression test to check whether f2fs handles dirty
> > > data correctly when checkpoint is disabled, if lfs mode is on,
> > > it will trigger OPU for all overwritten data, this will cost
> > > free segments, so f2fs must account overwritten data as OPU
> > > data when calculating free space, otherwise, it may run out
> > > of free segments in f2fs' allocation function, resulting in
> > > panic.
> > >=20
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v2:
> > > - add _fixed_by_kernel_commit()
> > > - use _scratch_mkfs_sized() rather than formating size-specified
> > > loop device
> > > - code cleanup
> > >   tests/f2fs/006     | 38 ++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/006.out |  6 ++++++
> > >   2 files changed, 44 insertions(+)
> > >   create mode 100755 tests/f2fs/006
> > >   create mode 100644 tests/f2fs/006.out
> > >=20
> > > diff --git a/tests/f2fs/006 b/tests/f2fs/006
> > > new file mode 100755
> > > index 00000000..63d00018
> > > --- /dev/null
> > > +++ b/tests/f2fs/006
> > > @@ -0,0 +1,38 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. f2fs/006
> > > +#
> > > +# This is a regression test to check whether f2fs handles dirty
> > > +# data correctly when checkpoint is disabled, if lfs mode is on,
> > > +# it will trigger OPU for all overwritten data, this will cost
> > > +# free segments, so f2fs must account overwritten data as OPU
> > > +# data when calculating free space, otherwise, it may run out
> > > +# of free segments in f2fs' allocation function, resulting in
> > > +# panic.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +	"f2fs: fix to account dirty data in __get_secs_required()"
> > > +
> > > +testfile=3D$SCRATCH_MNT/testfile
> > > +
> > > +_require_scratch
> > > +_scratch_mkfs_sized $((1024*1024*100)) >> $seqres.full
> > > +
> > > +# use mode=3Dlfs to let f2fs always triggers OPU
> > > +_scratch_mount -o mode=3Dlfs,checkpoint=3Ddisable:10%,noinline_dentr=
y >> $seqres.full
> > > +
> > > +dd if=3D/dev/zero of=3D$testfile bs=3D1M count=3D50 2>/dev/null
> > > +
> > > +# it may run out of free space of f2fs and hang kernel
> > > +dd if=3D/dev/zero of=3D$testfile bs=3D1M count=3D50 conv=3Dnotrunc c=
onv=3Dfsync
> > > +dd if=3D/dev/zero of=3D$testfile bs=3D1M count=3D50 conv=3Dnotrunc c=
onv=3Dfsync
> >=20
> > What kind of failure should be printed at here if test on unfixed kerne=
l?
>=20
> It will panic kernel w/o fix, can you please check dmesg?

The dmesg as below [2]. But it hit EIO [1], rather than ENOSPC, and didn't =
hang.
If it's the same issue, or another issue, I think we can explain it in abov=
e comment.

Thanks,
Zorro


[1]
# diff -u /root/git/xfstests/tests/f2fs/006.out /root/git/xfstests/results/=
/default/f2fs/006.out.bad
--- /root/git/xfstests/tests/f2fs/006.out       2024-10-28 20:51:08.3810204=
24 +0800
+++ /root/git/xfstests/results//default/f2fs/006.out.bad        2024-10-28 =
20:54:33.252246497 +0800
@@ -1,6 +1,6 @@
 QA output created by 006
 50+0 records in
 50+0 records out
-dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
-3+0 records in
-2+0 records out
+dd: fsync failed for '/mnt/scratch/testfile': Input/output error
+50+0 records in
+50+0 records out

[2]
[3370744.465936] run fstests f2fs/006 at 2024-10-28 20:54:27
[3370746.308401] F2FS-fs (sda6): Adjust unusable cap for checkpoint=3Ddisab=
le =3D 1530 / 10%
[3370746.318664] F2FS-fs (sda6): Found nat_bits in checkpoint
[3370746.341354] F2FS-fs (sda6): Start checkpoint disabled!
[3370746.347782] F2FS-fs (sda6): Mounted with checkpoint version =3D 355eea=
66
[3370747.846817] F2FS-fs (sda6): Stopped filesystem due to reason: 7
[3370747.853002] ------------[ cut here ]------------
[3370747.857826] WARNING: CPU: 1 PID: 791405 at fs/f2fs/segment.c:2748 new_=
curseg+0xc7e/0x1ef0 [f2fs]
[3370747.866938] Modules linked in: f2fs crc32_generic lz4hc_compress lz4_c=
ompress dm_thin_pool dm_persistent_data dm_bio_prison dm_log_writes xfs mlx=
5_ib ib_uverbs macsec ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fi=
b intel_rapl_msr intel_rapl_common nft_reject_inet nf_reject_ipv4 nf_reject=
_ipv6 intel_uncore_frequency nft_reject intel_uncore_frequency_common i10nm=
_edac skx_edac_common nft_ct nfit x86_pkg_temp_thermal intel_powerclamp nft=
_chain_nat nf_nat coretemp rfkill nf_conntrack nf_defrag_ipv6 kvm_intel nf_=
defrag_ipv4 snd_pcsp mlx5_core dax_hmem snd_pcm kvm ip_set cxl_acpi snd_tim=
er spi_nor dell_pc iTCO_wdt rapl cxl_core intel_pmc_bxt snd dell_smbios acp=
i_power_meter iTCO_vendor_support mtd mlxfw ipmi_ssif intel_cstate platform=
_profile nf_tables dcdbas nd_pmem isst_if_mmio isst_if_mbox_pci psample dax=
_pmem nd_btt intel_uncore dell_wmi_descriptor wmi_bmof einj soundcore tls m=
ei_me tg3 intel_th_gth spi_intel_pci i2c_i801 isst_if_common pci_hyperv_int=
f mei spi_intel intel_th_pci i2c_smbus intel_pch_thermal
[3370747.867283]  ipmi_si intel_th intel_vsec acpi_ipmi ipmi_devintf ipmi_m=
sghandler fuse loop nfnetlink zram crct10dif_pclmul crc32_pclmul crc32c_int=
el polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 nd_e820=
 sha256_ssse3 libnvdimm sha1_ssse3 megaraid_sas mgag200 i2c_algo_bit wmi [l=
ast unloaded: scsi_debug]
[3370747.985397] CPU: 1 UID: 0 PID: 791405 Comm: dd Tainted: G        W    =
     -------  ---  6.11.0-0.rc6.49.fc42.x86_64+debug #1
[3370747.996895] Tainted: [W]=3DWARN
[3370748.000067] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4=
 12/17/2021
[3370748.007747] RIP: 0010:new_curseg+0xc7e/0x1ef0 [f2fs]
[3370748.012949] Code: 8e 38 0b 00 00 3b ab d8 11 00 00 0f 82 b3 f8 ff ff 4=
8 8b 7c 24 28 e8 f1 26 5b f0 ba 07 00 00 00 31 f6 48 89 df e8 42 6b f7 ff <=
0f> 0b be 08 00 00 00 48 8d bb 20 01 00 00 e8 3f db d1 ed f0 80 8b
[3370748.031898] RSP: 0018:ffa00000365cea90 EFLAGS: 00010296
[3370748.037323] RAX: 0000000000000000 RBX: ff1100110a61c000 RCX: 000000000=
0000000
[3370748.044656] RDX: 0000000000000033 RSI: ffffffffb2c56fe0 RDI: fff3fc000=
6cb9d23
[3370748.051989] RBP: 000000000000002a R08: 0000000000000001 R09: fff3fc000=
6cb9ce8
[3370748.059319] R10: ffa00000365ce747 R11: 0000000000000000 R12: 000000000=
0000001
[3370748.066652] R13: ff110009482c4178 R14: ff11001096338e00 R15: ffe21c022=
14c3a3b
[3370748.073984] FS:  00007f9d7a3d4740(0000) GS:ff11002031000000(0000) knlG=
S:0000000000000000
[3370748.082269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[3370748.088211] CR2: 000056272e350c08 CR3: 0000001100088002 CR4: 000000000=
0771ef0
[3370748.095546] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[3370748.102906] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[3370748.110236] PKRU: 55555554
[3370748.113149] Call Trace:
[3370748.115800]  <TASK>
[3370748.118106]  ? __warn.cold+0x5b/0x1af
[3370748.121975]  ? new_curseg+0xc7e/0x1ef0 [f2fs]
[3370748.126575]  ? report_bug+0x1fc/0x3d0
[3370748.130449]  ? handle_bug+0x3c/0x80
[3370748.134141]  ? exc_invalid_op+0x17/0x40
[3370748.138181]  ? asm_exc_invalid_op+0x1a/0x20
[3370748.142591]  ? new_curseg+0xc7e/0x1ef0 [f2fs]
[3370748.147200]  ? update_segment_mtime+0x144/0x4c0 [f2fs]
[3370748.152591]  f2fs_allocate_data_block+0xbc9/0x4070 [f2fs]
[3370748.158244]  ? mark_lock+0xf5/0x16d0
[3370748.162021]  ? __pfx___lock_acquire+0x10/0x10
[3370748.166603]  ? __pfx_f2fs_allocate_data_block+0x10/0x10 [f2fs]
[3370748.172676]  ? __pfx___get_segment_type+0x10/0x10 [f2fs]
[3370748.178231]  ? folio_memcg_unlock+0x61/0x120
[3370748.182707]  ? local_clock_noinstr+0xd/0x100
[3370748.187191]  do_write_page+0x156/0xdf0 [f2fs]
[3370748.191789]  ? __pfx___update_extent_cache+0x10/0x10 [f2fs]
[3370748.197596]  ? mark_held_locks+0x94/0xe0
[3370748.201727]  ? __pfx_do_write_page+0x10/0x10 [f2fs]
[3370748.206865]  ? __folio_start_writeback+0x266/0x870
[3370748.211873]  f2fs_outplace_write_data+0x198/0x310 [f2fs]
[3370748.217419]  ? __pfx_f2fs_outplace_write_data+0x10/0x10 [f2fs]
[3370748.223503]  f2fs_do_write_data_page+0xaf9/0x1120 [f2fs]
[3370748.229175]  ? __pfx_f2fs_do_write_data_page+0x10/0x10 [f2fs]
[3370748.235176]  ? __pfx___lock_acquire+0x10/0x10
[3370748.239748]  f2fs_write_single_data_page+0xf9f/0x16e0 [f2fs]
[3370748.245674]  ? __pfx_f2fs_write_single_data_page+0x10/0x10 [f2fs]
[3370748.252007]  ? local_clock_noinstr+0xd/0x100
[3370748.256482]  ? folio_clear_dirty_for_io+0x20b/0x5b0
[3370748.261567]  ? local_clock_noinstr+0xd/0x100
[3370748.266081]  f2fs_write_cache_pages+0xa46/0x1ec0 [f2fs]
[3370748.271573]  ? __pfx_f2fs_write_cache_pages+0x10/0x10 [f2fs]
[3370748.277486]  ? __pfx___lock_acquire+0x10/0x10
[3370748.282051]  ? mark_lock+0xf5/0x16d0
[3370748.285869]  ? f2fs_write_data_pages+0x844/0xc00 [f2fs]
[3370748.291352]  ? rcu_is_watching+0x12/0xc0
[3370748.295482]  ? trace_contention_end+0xd4/0x110
[3370748.300190]  f2fs_write_data_pages+0x85d/0xc00 [f2fs]
[3370748.305491]  ? __pfx_f2fs_write_data_pages+0x10/0x10 [f2fs]
[3370748.311293]  ? __pfx___lock_acquire+0x10/0x10
[3370748.315889]  do_writepages+0x176/0x780
[3370748.319860]  ? __pfx_do_writepages+0x10/0x10
[3370748.324329]  ? filemap_fdatawrite_wbc+0xd3/0x180
[3370748.329162]  ? do_raw_spin_unlock+0x58/0x1f0
[3370748.333641]  ? _raw_spin_unlock+0x2d/0x50
[3370748.337859]  ? wbc_attach_and_unlock_inode+0x3da/0x7d0
[3370748.343204]  filemap_fdatawrite_wbc+0x113/0x180
[3370748.347939]  __filemap_fdatawrite_range+0xaf/0xf0
[3370748.352855]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[3370748.358515]  ? __pfx_lock_release+0x10/0x10
[3370748.362909]  file_write_and_wait_range+0x9b/0x110
[3370748.367819]  f2fs_do_sync_file+0x27b/0x1ab0 [f2fs]
[3370748.372882]  ? __pfx_f2fs_do_sync_file+0x10/0x10 [f2fs]
[3370748.378348]  ? __pfx_vfs_read+0x10/0x10
[3370748.382452]  ? __mark_inode_dirty+0x6ef/0x9d0
[3370748.387018]  ? ksys_read+0xfb/0x1d0
[3370748.390715]  ? vfs_fsync_range+0x11b/0x220
[3370748.395024]  __x64_sys_fsync+0x59/0xa0
[3370748.398980]  do_syscall_64+0x97/0x190
[3370748.402861]  ? __pfx_ksys_read+0x10/0x10
[3370748.406995]  ? lockdep_hardirqs_on_prepare+0x171/0x400
[3370748.412336]  ? do_syscall_64+0xa3/0x190
[3370748.416380]  ? lockdep_hardirqs_on+0x7c/0x100
[3370748.420941]  ? do_syscall_64+0xa3/0x190
[3370748.424981]  ? lockdep_hardirqs_on_prepare+0x171/0x400
[3370748.430324]  ? do_syscall_64+0xa3/0x190
[3370748.434364]  ? lockdep_hardirqs_on+0x7c/0x100
[3370748.438924]  ? do_syscall_64+0xa3/0x190
[3370748.442969]  ? do_syscall_64+0xa3/0x190
[3370748.447009]  ? lockdep_hardirqs_on_prepare+0x171/0x400
[3370748.452349]  ? do_syscall_64+0xa3/0x190
[3370748.456394]  ? lockdep_hardirqs_on+0x7c/0x100
[3370748.460953]  ? do_syscall_64+0xa3/0x190
[3370748.464994]  ? do_syscall_64+0xa3/0x190
[3370748.469039]  ? lockdep_hardirqs_on_prepare+0x171/0x400
[3370748.474380]  ? do_syscall_64+0xa3/0x190
[3370748.478427]  ? lockdep_hardirqs_on+0x7c/0x100
[3370748.483043]  ? clear_bhb_loop+0x25/0x80
[3370748.487082]  ? clear_bhb_loop+0x25/0x80
[3370748.491127]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[3370748.496383] RIP: 0033:0x7f9d7a4c11a4
[3370748.500187] Code: 00 00 0f 1f 40 00 f3 0f 1e fa 48 8b 3d 9d 5c 10 00 e=
9 10 73 f1 ff f3 0f 1e fa 80 3d c5 5e 10 00 00 74 13 b8 4a 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 4
8 89 e5 48 83 ec 10 89 7d
[3370748.519133] RSP: 002b:00007fff6c1e62c8 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000004a
[3370748.526905] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d7=
a4c11a4
[3370748.534239] RDX: 0000000000000032 RSI: 0000000000000000 RDI: 000000000=
0000001
[3370748.541568] RBP: 00007fff6c1e6320 R08: 0000000000000000 R09: 00007f9d7=
a60c380
[3370748.548932] R10: 0000000000000022 R11: 0000000000000202 R12: 00007f9d7=
a3d46c8
[3370748.556268] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000032
[3370748.563625]  </TASK>
[3370748.566016] irq event stamp: 342211
[3370748.569711] hardirqs last  enabled at (342221): [<ffffffffaf41b9f6>] c=
onsole_unlock+0x236/0x2c0
[3370748.578611] hardirqs last disabled at (342230): [<ffffffffaf41b9db>] c=
onsole_unlock+0x21b/0x2c0
[3370748.587504] softirqs last  enabled at (342178): [<ffffffffaf247c3b>] _=
_irq_exit_rcu+0xbb/0x1c0
[3370748.596307] softirqs last disabled at (342157): [<ffffffffaf247c3b>] _=
_irq_exit_rcu+0xbb/0x1c0
[3370748.605115] ---[ end trace 0000000000000000 ]---
[3370748.792483] F2FS-fs (sda6): Adjust unusable cap for checkpoint=3Ddisab=
le =3D 1530 / 10%
[3370750.194429] F2FS-fs (sda6): Disable nat_bits due to incorrect cp_ver (=
4137321793606052454, 18446744073709551615)
[3370750.259391] F2FS-fs (sda6): Mounted with checkpoint version =3D 355eea=
67


>=20
> > I got:
> >=20
> > # diff -u /root/git/xfstests/tests/f2fs/006.out /root/git/xfstests/resu=
lts//default/f2fs/006.out.bad|less
> > --- /root/git/xfstests/tests/f2fs/006.out       2024-10-25 11:33:54.693=
883281 +0800
> > +++ /root/git/xfstests/results//default/f2fs/006.out.bad        2024-10=
-25 11:34:55.907252401 +0800
> > @@ -1,6 +1,6 @@
> >   QA output created by 006
> >   50+0 records in
> >   50+0 records out
> > -dd: error writing '/mnt/scratch_f2fs/testfile': No space left on device
> > -3+0 records in
> > -2+0 records out
> > +dd: fsync failed for '/mnt/scratch/testfile': Input/output error
> > +50+0 records in
> > +50+0 records out
> >=20
> > Does that mean the bug is reproduced?
> > >> +
> > > +_scratch_remount checkpoint=3Denable
> > > +
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/f2fs/006.out b/tests/f2fs/006.out
> > > new file mode 100644
> > > index 00000000..0d7b3910
> > > --- /dev/null
> > > +++ b/tests/f2fs/006.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 006
> > > +50+0 records in
> > > +50+0 records out
> > > +dd: error writing '/mnt/scratch_f2fs/testfile': No space left on dev=
ice
> >=20
> > The "/mnt/scratch_f2fs" should be SCRATCH_MNT, please use _filter_scrat=
ch()
> > by importing common/filter.
>=20
> Correct, let me fix this.
>=20
> Thanks,
>=20
> >=20
> > > +3+0 records in
> > > +2+0 records out
> > > --=20
> > > 2.40.1
> > >=20
> >=20
>=20


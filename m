Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeC2Dq0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Mar 2018 23:46:26 -0400
Date: Thu, 29 Mar 2018 11:46:22 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: test inode allocation state missmatch corruption
Message-ID: <20180329034621.GR4684@dhcp12-143.nay.redhat.com>
References: <20180328140631.13944-1-zlang@redhat.com>
 <20180328162437.GC11581@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328162437.GC11581@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 28, 2018 at 09:24:37AM -0700, Darrick J. Wong wrote:
> On Wed, Mar 28, 2018 at 10:06:31PM +0800, Zorro Lang wrote:
> > There's a situation where the directory structure and the inobt
> > thinks the inode is free, but the inode on disk thinks it is still
> > in use. XFS should detect it and prevent the kernel from oopsing
> > on lookup.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > There's a weird issue:
> > 
> > When run this case on upstream general kernel(4.16-rc6 without
> > XFS_WARN/XFS_DEBUG config), it trigger a soft lockup bug[1],
> > and the case block there. But if I use Dave's patch:
> > (https://marc.info/?l=linux-xfs&m=152161877728015&w=2)
> > test passed. I don't know if this softlockup bug is what
> > Dave tried to fix in his patch too?
> > 
> > If I test on upstream kernel with XFS_WARN, I didn't hit this
> > soft lockup issue, just below issue as expected:
> > XFS: Assertion failed: ip->i_d.di_nblocks == 0, file: fs/xfs/xfs_inode.c
> > 
> > When I test on RHEL-7 debug kernel (with XFS_WARN), trigger the
> > soft lockup bug again.
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > [  455.751099] watchdog: BUG: soft lockup - CPU#12 stuck for 22s! [umount:2631]
> > [  455.781145] Modules linked in: sunrpc coretemp intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni
> > _intel aes_x86_64 crypto_simd glue_helper cryptd intel_cstate hpilo intel_rapl_perf wmi ipmi_si iTCO_wdt hpwdt iTCO_vendor_support ipmi_devintf sg ipmi_msghandler acpi_power_meter ioatdma pcs
> > pkr shpchp i2c_i801 pcc_cpufreq dca lpc_ich ip_tables xfs libcrc32c uas usb_storage sd_mod tg3 hwmon mgag200 xhci_pci ptp crc32c_intel serio_raw xhci_hcd hpsa ttm pps_core scsi_transport_sas
> > dm_mirror dm_region_hash dm_log dm_mod dax ipv6 crc_ccitt autofs4
> > [  456.029470] CPU: 12 PID: 2631 Comm: umount Tainted: G             L   4.16.0-rc6+ #3
> > [  456.058306] Hardware name: HP ProLiant DL360 Gen9, BIOS P89 05/06/2015
> > [  456.081804] RIP: 0010:fsnotify_unmount_inodes+0xcc/0x100
> > [  456.099735] RSP: 0018:ffffc900074b3e50 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff12
> > [  456.127922] RAX: 0000000000000000 RBX: ffff88045cecd178 RCX: 000000000000001b
> > [  456.154306] RDX: 0000000000000001 RSI: ffffc900074b3d30 RDI: ffff88045cecd200
> > [  456.180539] RBP: 0000000000000000 R08: 000000000000000f R09: ffffc900074b3db8
> > [  456.206731] R10: 000000000000035c R11: 0000000000000018 R12: ffff880465c1cd88
> > [  456.232869] R13: ffff880465c1c800 R14: ffff880465c1cd80 R15: 0000000000000000
> > [  456.259048] FS:  00007f698e06b880(0000) GS:ffff88046f500000(0000) knlGS:0000000000000000
> > [  456.292396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  456.314274] CR2: 000055ae574a4628 CR3: 00000004699d6002 CR4: 00000000001606e0
> > [  456.340388] Call Trace:
> > [  456.345439]  generic_shutdown_super+0x32/0x110
> > [  456.359532]  kill_block_super+0x21/0x50
> > [  456.370883]  deactivate_locked_super+0x3f/0x70
> > [  456.384883]  cleanup_mnt+0x3b/0x70
> > [  456.394269]  task_work_run+0x92/0xb0
> > [  456.404408]  exit_to_usermode_loop+0x6c/0x99
> > [  456.417663]  do_syscall_64+0xf5/0x130
> > [  456.428266]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> > [  456.445027] RIP: 0033:0x7f698d2ddb87
> > [  456.455141] RSP: 002b:00007fffb980d058 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> > [  456.483339] RAX: 0000000000000000 RBX: 000055ae5749c080 RCX: 00007f698d2ddb87
> > [  456.509478] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055ae574a3460
> > [  456.535573] RBP: 000055ae574a3460 R08: 000055ae574a3480 R09: 0000000000000000
> > [  456.561797] R10: 00007fffb980cae0 R11: 0000000000000246 R12: 00007f698de58d58
> > [  456.588281] R13: 0000000000000000 R14: 000055ae5749c270 R15: 000055ae5749c080
> > [  456.614425] Code: 8d 98 e0 fe ff ff 74 2c 48 8d bb 88 00 00 00 e8 5b fa 52 00 f6 83 a0 00 00 00 38 75 0e 8b 83 58 01 00 00 85 c0 0f 85 74 ff ff ff <c6> 83 88 00 00 00 00 eb c1 41 c6 85 80 05 00 00 00 48 85 ed 74

Any idea about if this's https://marc.info/?l=linux-xfs&m=152161877728015&w=2 try to fix?

> > 
> > 
> > 
> >  tests/xfs/444     | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/444.out |   2 +
> >  tests/xfs/group   |   1 +
> >  3 files changed, 129 insertions(+)
> >  create mode 100755 tests/xfs/444
> >  create mode 100644 tests/xfs/444.out
> > 
> > diff --git a/tests/xfs/444 b/tests/xfs/444
> > new file mode 100755
> > index 00000000..58848f4f
> > --- /dev/null
> > +++ b/tests/xfs/444
> > @@ -0,0 +1,126 @@
> > +#! /bin/bash
> > +# FS QA Test 444
> > +#
> > +# Test a corruption when the directory structure and the inobt thinks the inode
> > +# is free, but the inode on disk thinks it is still in use.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2018 YOUR NAME HERE.  All Rights Reserved.
> 
> Nice patch Mr. HERE.

Ah, I always forgot changing this in V1 patch...

> 
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_scratch_nocheck
> > +_require_no_xfs_bug_on_assert
> > +
> > +_filter_dmesg()
> > +{
> > +	local warn1="Internal error xfs_trans_cancel.*fs/xfs/xfs_trans\.c.*"
> > +	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
> > +
> > +	sed -e "s#$warn1#Intentional error in xfs_trans_cancel#" \
> > +	    -e "s#$warn2#Intentional warnings in assfail#"
> > +}
> > +# If the expected behivor is kernel warning, dissable dmesg, need more check!
> > +#_disable_dmesg_check
> 
> Why is this commented out?  Can it go away?

Yeah, it should be removed.

> 
> > +
> > +# Use crc=0, due to this crash is only possible on v4 XFS or v5 XFS mounted
> > +# with the ikeep mount option. For all other V5 XFS, this problem cannot
> > +# occur because we don't read inodes we are allocating from disk - we simply
> > +# overwrite them with the new inode information.
> > +_scratch_mkfs_xfs -m crc=0 >> $seqres.full 2>&1
> > +blksz=$(_scratch_xfs_get_sb_field blocksize)
> > +agcount=$(_scratch_xfs_get_sb_field agcount)
> > +
> > +_scratch_mount
> > +# Create a directory for later allocation in same AG (AG 0, due to this's an
> > +# empty XFS for now)
> > +mkdir $SCRATCH_MNT/dir
> > +
> > +# Allocate 1 block for testfile
> > +$XFS_IO_PROG -fc 'pwrite 0 $blksz' -c fsync $SCRATCH_MNT/dir/testfile >> $seqres.full
> > +_scratch_unmount
> > +
> > +# We only have one file in one directory (it's generally in AGI 0). So only
> > +# one AG has free inodes (XFS allocates inodes in chunks of 64), so the
> > +# AG which has the testfile, its freecount should not be 0.
> > +for ((agi=0; agi<agcount; agi++)); do
> > +	freecount=$(_scratch_xfs_get_metadata_field freecount "agi $agi")
> > +	if [ "$freecount" != "0" ]; then
> > +		break
> > +	fi
> > +done
> > +# Make sure we found the AG contains the testfile
> > +if [ $agi -gt $agcount ]; then
> > +	_fail "Can't find testfile in which AG"
> > +fi
> 
> Can't we figure out which AG the testfile inode is in from the inode
> number directly?

Sure, thanks for you told me how to do that:)

> 
> > +# Due to we only allocate 1 block for testfile, and this's the only one data
> > +# block we use. So we use single level inobt, So the ${agi}->root->recs[1]
> > +# should be the only one record points the chunk which contains testfile's
> > +# inode.
> > +# An exmaple of inode record is as below:
> > +#   recs[1] = [startino,freecount,free] 1:[1024,59,0xffffffffffffffe0]
> > +freecount=$(_scratch_xfs_get_metadata_field "recs[1].freecount" \
> > +					    "agi $agi" "addr root")
> > +fmask=$(_scratch_xfs_get_metadata_field "recs[1].free" "agi $agi" "addr root")
> > +
> > +# fmask shift right 1 bit, and freecount++, to mark testfile inode as free in
> > +# inobt. (But the inode itself isn't freed, it still has allocated block)
> > +freecount="$((freecount + 1))"
> > +fmask="$((fmask / 2))"
> 
> TBH I was expecting this to find testfile's inode number, set
> freecount=1, and then reset the freemask so that testfile is the only
> free inode in the chunk, thereby forcing(?) the next allocation to end
> up with testfile's inode and reproduce the crash.  Not sure why we're
> shifting right by one bit?
> 
> tldr: I'm confused :)

Hmmm... a little confused at here. Do you mean this:
  # stat -c %i /mnt/test/dir/testfile 
  1028
  # umount $dev
  # xfs_db -x $dev
  xfs_db> inode 1028
  xfs_db> convert inode 1028 agno
  0x0 (0)
  xfs_db> agi 0
  xfs_db> addr root
  xfs_db> p
  magic = 0x49414254
  level = 0
  numrecs = 1
  leftsib = null
  rightsib = null
  recs[1] = [startino,freecount,free] 1:[1024,59,0xffffffffffffffe0]
  xfs_db> write recs[1].startino 1028
  recs[1].startino = 1028
  xfs_db> write recs[1].freecount 1
  recs[1].freecount = 1
  xfs_db> write recs[1].free 1
  recs[1].free = 0x1
  xfs_db> q

But after mount this XFS again, and tried to do `touch /mnt/test/dir/newfile`,
I got this warning:

[47420.479191] XFS: Assertion failed: fs_is_ok, file: fs/xfs/libxfs/xfs_ialloc.c, line: 1156                                                                                          [45/9735]
[47420.520226] ------------[ cut here ]------------
[47420.543399] WARNING: CPU: 13 PID: 2267 at fs/xfs/xfs_message.c:105 asswarn+0x33/0x40 [xfs]
....
[47421.791340] XFS (dm-2): Internal error XFS_WANT_CORRUPTED_GOTO at line 1156 of file fs/xfs/libxfs/xfs_ialloc.c.  Caller xfs_dialloc_ag+0x6e/0x360 [xfs]
....

Hmm... I'm confused.

> 
> > +_scratch_xfs_set_metadata_field "recs[1].freecount" "$freecount" \
> > +				"agi $agi" "addr root" >/dev/null
> > +_scratch_xfs_set_metadata_field "recs[1].free" "$fmask" \
> > +				"agi $agi" "addr root" >/dev/null
> > +
> > +# Mount again and create a new inode cover that inode we just 'freed' from inobt
> > +_scratch_mount
> > +$XFS_IO_PROG -fc 'pwrite 0 $blksz' -c fsync $SCRATCH_MNT/dir/newfile 2>&1 | \
> > +	grep -i "Structure needs cleaning" | _filter_scratch
> 
> How often does this fail to allocate the inode we've messed with?

Everytime in my test

Thanks,
Zorro.

> 
> --D
> 
> > +
> > +# filter a intentional internal errors
> > +_check_dmesg _filter_dmesg
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/444.out b/tests/xfs/444.out
> > new file mode 100644
> > index 00000000..2daaf2fc
> > --- /dev/null
> > +++ b/tests/xfs/444.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 444
> > +SCRATCH_MNT/dir/newfile: Structure needs cleaning
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index e2397fe6..831f2cfa 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -441,3 +441,4 @@
> >  441 auto quick clone quota
> >  442 auto stress clone quota
> >  443 auto quick ioctl fsr
> > +444 auto quick
> > -- 
> > 2.14.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

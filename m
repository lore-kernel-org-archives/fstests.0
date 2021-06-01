Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925ADC47080
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1FD613B1
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 14:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhFAOCx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17023 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234038AbhFAOCw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Jun 2021 10:02:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151DXtNC146982;
        Tue, 1 Jun 2021 10:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=fO+lTs4FqNZ9DSPcSuCj0He5nw5TcWtIsZjMmD2bh40=;
 b=goJw5b2cbLp7bKAHbiJKe5aumH87x6u6VfEsIUupoLzdVFpjN2hIG20eZc/XgsOJxzep
 EArHooXGFFeyjc07dnzvIPCfUr6llDT7U13xO1DcMfP9DU9RcR3+qiZSapIqPsWDX7Q2
 qrxorcETolDzlnuatW74D2lRl46fzt5xKeTu61HHDPNSTQxd6wsw2oQ8WW/2Haejelpf
 6RC9VtIoh6X1cRTpsUKYyWZ7iZi0nZ6yCwwUKZ8BztfX6QIcCv6mWIa0kzxcPRaCXjj5
 6d5sZAk6XwxDNhq2o8SeLFwcfL8DW9xvvV+cNPpvjB881Yy8vurh0sYUMvIbNSoWw5Oh qA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38wnej1vys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 10:01:05 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151E13e6010671;
        Tue, 1 Jun 2021 14:01:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 38ucvh8yg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 14:01:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151E11WI30605570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 14:01:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13F175206B;
        Tue,  1 Jun 2021 14:01:01 +0000 (GMT)
Received: from localhost (unknown [9.85.75.172])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B8FFE52052;
        Tue,  1 Jun 2021 14:01:00 +0000 (GMT)
Date:   Tue, 1 Jun 2021 19:30:59 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstest <fstests@vger.kernel.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: xfs_db causing OOM failures while running fstests on 64k blocksize
Message-ID: <20210601140059.d3juwiacnx3zyem7@riteshh-domain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSj0Vnav-VeJ4d4JVs6qrx0-WaEJeJiC
X-Proofpoint-ORIG-GUID: aSj0Vnav-VeJ4d4JVs6qrx0-WaEJeJiC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_06:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=776 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010092
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello Darrick,

With 64K blocksize, we are running into this OOM failure invoked by xfs_db on
our test machines. Due to this, internally many times we are unable to get a
report of fstests for xfs on Power. This is quite easily seen with 64K blocksize.

I remember you were mentioning some solution around this in one of the call.
Something that you may have some patches in your tree, but also that there could
be some more work required in this area to fix the issue.
Sorry, I don't recollect our discussion completely. It was something around
xfs_check and xfs_repair. Could you please help understand once again on why
this issue? (even with quite high RAM size and small disk size)
And any known workaround for this?

Also would you like some help with this work? Since it is anyway required for
Power, so someone internally from our team can also start to work on this.


e.g. log
generic/234		[12:08:15][ 5800.944162] run fstests generic/234 at 2021-04-24 12:08:15
[ 5802.188921] XFS (vdd): Mounting V5 Filesystem
[ 5802.280632] XFS (vdd): Ending clean mount
[ 5802.337718] xfs filesystem being mounted at /vdd supports timestamps until 2038 (0x7fffffff)
[ 5803.069534] XFS (vdc): Mounting V5 Filesystem
[ 5803.121686] XFS (vdc): Ending clean mount
[ 5803.123598] XFS (vdc): Quotacheck needed: Please wait.
[ 5803.166977] XFS (vdc): Quotacheck: Done.
[ 5803.170940] xfs filesystem being mounted at /vdc supports timestamps until 2038 (0x7fffffff)
[ 5831.708588] XFS (vdc): Unmounting Filesystem
[ 5832.530761] XFS (vdd): Unmounting Filesystem
[ 5854.828260] xfs_db invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=-1000
[ 5854.828717] CPU: 0 PID: 16727 Comm: xfs_db Not tainted 5.12.0-rc8-00043-g8db5efb83fa9 #20
[ 5854.828868] Call Trace:
[ 5854.828916] [c0000000204b7750] [c000000000c0ce88] dump_stack+0xec/0x144 (unreliable)
[ 5854.829145] [c0000000204b7790] [c00000000042a054] dump_header+0x64/0x414
[ 5854.829306] [c0000000204b7810] [c000000000427cb8] oom_kill_process+0x108/0x350
[ 5854.829495] [c0000000204b7850] [c000000000429dd4] out_of_memory+0x874/0x9b0
[ 5854.829647] [c0000000204b78f0] [c0000000004c95b8] __alloc_pages_slowpath.constprop.85+0xe98/0x11e0
[ 5854.829852] [c0000000204b7ac0] [c0000000004c9c1c] __alloc_pages_nodemask+0x31c/0x500
[ 5854.830029] [c0000000204b7b50] [c0000000004f77e4] alloc_pages_vma+0x2b4/0x320
[ 5854.830209] [c0000000204b7bc0] [c0000000004913c4] __handle_mm_fault+0xb14/0x1790
[ 5854.830389] [c0000000204b7ca0] [c000000000492390] handle_mm_fault+0x350/0x4c0
[ 5854.830568] [c0000000204b7d00] [c00000000009c914] ___do_page_fault+0x9a4/0xd30
[ 5854.830750] [c0000000204b7db0] [c00000000009ccd4] __do_page_fault+0x34/0x90
[ 5854.830901] [c0000000204b7de0] [c0000000000a6268] do_hash_fault+0x48/0x90
[ 5854.831053] [c0000000204b7e10] [c000000000008994] data_access_common_virt+0x194/0x1f0
<...>
[ 5854.833718] --- interrupt: 300
[ 5854.833797] Mem-Info:
[ 5854.833866] active_anon:15 inactive_anon:158676 isolated_anon:0
[ 5854.833866]  active_file:14 inactive_file:0 isolated_file:0
[ 5854.833866]  unevictable:0 dirty:0 writeback:0
[ 5854.833866]  slab_reclaimable:741 slab_unreclaimable:1835
[ 5854.833866]  mapped:101 shmem:493 pagetables:77 bounce:0
[ 5854.833866]  free:174 free_pcp:2 free_cma:0
[ 5854.834514] Node 0 active_anon:960kB inactive_anon:10155264kB active_file:896kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:6464kB dirty:0kB writeback:0kB shmem:31552kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:1280kB pagetables:4928kB all_unreclaimable? yes
[ 5854.835088] Node 0 Normal free:11136kB min:12800kB low:23104kB high:33408kB reserved_highatomic:0KB active_anon:960kB inactive_anon:10155264kB active_file:896kB inactive_file:0kB unevictable:0kB writepending:0kB present:10485760kB managed:10399232kB mlocked:0kB bounce:0kB free_pcp:128kB local_pcp:128kB free_cma:0kB
[ 5854.835641] lowmem_reserve[]: 0 0 0
[ 5854.835787] Node 0 Normal: 94*64kB (UE) 24*128kB (U) 4*256kB (U) 2*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB = 11136kB
[ 5854.836091] 507 total pagecache pages
[ 5854.836182] 0 pages in swap cache
[ 5854.836273] Swap cache stats: add 0, delete 0, find 0/0
[ 5854.836369] Free swap  = 0kB
[ 5854.836463] Total swap = 0kB
[ 5854.836554] 163840 pages RAM
[ 5854.836645] 0 pages HighMem/MovableOnly
[ 5854.836737] 1352 pages reserved
[ 5854.836830] 0 pages cma reserved
[ 5854.836923] 0 pages hwpoisoned
[ 5854.837034] Tasks state (memory values in pages):
[ 5854.837151] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[ 5854.837355] [   1397]     0  1397      512      117    43008        0             0 systemd-journal
[ 5854.837755] [   1406]     0  1406      122       26    38912        0             0 blkmapd
[ 5854.837926] [   1606]     0  1606      337       47    40960        0         -1000 systemd-udevd
[ 5854.838121] [   2496]   101  2496     1502       74    43008        0             0 systemd-timesyn
[ 5854.838314] [   2498]   106  2498      176       48    38912        0             0 rpcbind
[ 5854.838483] [   2503]   104  2503      167       47    38912        0          -900 dbus-daemon
[ 5854.838676] [   2504]     0  2504      126       18    38912        0             0 kvm-xfstests.bo
[ 5854.838869] [   2505]     0  2505      344       72    40960        0             0 systemd-logind
[ 5854.839062] [   2537]     0  2537      190       63    38912        0             0 login
[ 5854.839231] [   2538]     0  2538       60       10    38912        0             0 agetty
[ 5854.839400] [   2540]     0  2540      190       63    38912        0             0 login
[ 5854.839570] [   2541]     0  2541      190       63    38912        0             0 login
[ 5854.839739] [   2613]     0  2613      132       22    38912        0             0 runtests.sh
[ 5854.839934] [   3114]     0  3114      144       35    38912        0             0 bash
[ 5854.840105] [   3115]     0  3115      144       35    38912        0             0 bash
[ 5854.840274] [   3116]     0  3116      144       35    38912        0             0 bash
[ 5854.840442] [  15152]     0 15152      182       75    38912        0         -1000 bash
[ 5854.840610] [  16727]     0 16727   157168   157096  1294336        0         -1000 xfs_db

-ritesh

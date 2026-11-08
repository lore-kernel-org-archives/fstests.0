Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104394;
	b=bp5NeIXD605317OzJhxjPSxS/p9Ho1sUNtvN8Z/RW97b64bCIhGgoCpbED/CCz/N0d0s
	 gnpcl9CsjkA7T/6zI3JtIxVgm69SWc2kShd5mfbDuS3LdYMLm98gF8xXr+V5hR06CrAMX
	 87bZnunDRWTsjqm1ooRw5bZoqj9yforWlDD6QE50AFbVcoR+ISUP91uOIgkTP352S7JHa
	 e4WqHUPzipR3zEXyKuC6bsywHANoyU2poa00fW41tHC+7MCfImDwPvymfxNGj9o6KB5My
	 l2E6fU6SWgX/bT11ZfPZ++2tovQj0dBiwh9h6hw+GwyAGlGXNLxosBJHXgBdE4cC9Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104394;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GZXHYpad4oOt5gixJMV6/CkxNmud5F9X+J+yEsrk7JE=;
	b=oUz6k73XyuDX6O9XGs/LyNAWVunqe7FlDreeAWHVGLeKD4yPrBfWBnEkYOXRPUI0/2G1
	 HuuBLN8HX/12tGZB6iEPliyNE8fIODLZwsU2uq4HrHvVgkrnttWd/uoMe8Nly9nPm6ci2
	 lCK9T2cP6ZTfLITmK4jNtIeoENCriT0TINDZATlRE50CQRs3fpqK6sU4rKuU+1Oo0QL2F
	 Lr6/o7gGmcXp5DlKO++DRLtbVvTatEu5T9fvA3XevpYAn4Hy+d06X8nPIMLveD77eOFN1
	 bk7VgPUitT2yloKUg6dJBoYz+NSuswK8Zo1S/LL8n/GbpLtpluQJkxYTZfnY57ffL1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FjtUEa5v;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Lxh7Dl6K;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5731606A338
	for <fstests@vger.kernel.org>; Sun,  8 Nov 2026 02:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5731606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=FjtUEa5v;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Lxh7Dl6K
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7NcE8P2355404
	for <fstests@vger.kernel.org>; Sat, 7 Nov 2026 21:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GZXH
	Ypad4oOt5gixJMV6/CkxNmud5F9X+J+yEsrk7JE=; b=FjtUEa5vOxAkt4JqNkc/
	SDKPFInVEKxSgr2PaegiD6xAczaV874iAdHPvImr5LIp71TTLO0Qqv2MG8tzfWko
	e3anoX6Ec9lf7GPI8Zm2+ccQX9E3FMjKqOdzYPiA8oLIEmGRXz4n8P5b5HRHvxm3
	+MglWcF+AeUIgFOodP0tCVUFk9swP1kl5oPppHItNpgQ/Pz7P9E7PKriNHq+23Qz
	cfLXVACEx0QMsr91ctUwPaCC9Gs7qAS5uzU5qpHmanZkkm/wZhQY2MRPeDcii/o9
	4Q5afWrcPOU2GHEBsVNvYny0GxD2/SY9OhrSe+ceZ5gHkZcvf0rcKR25fAbctSGA
	4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ht6yna3ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 21:19:46 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338c215ed2so3197781cf.0
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 18:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794104386; x=1794709186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZXHYpad4oOt5gixJMV6/CkxNmud5F9X+J+yEsrk7JE=;
        b=Lxh7Dl6KfqON/dbyn2uGLdVwtgwHuO3PRAoUw1GD0C9AsM2b14j+gYmNGjjn1+gIGb
         U96HvQy7sT4jlM8+af9vzt2Lr0YGubMP9iDA5if2k/joXWL4hh29XZYLNS7nYha4kH2U
         LadhlzRcgVcfrisKfXdhKzOqo7SPm85UMJdBkDi7svweJTcnqtXZu+oisedPv1sTpVct
         4FtAGi/3I1ylV/1sUlYl5PdHm1D7L+2Jrd39xXYqdCp/Rg0R02kFGPF5QPf7OPyRjPJR
         B8fAJ2AFTvU7VHDbOPW5jwFwTaR7JD2JeDoMxZV/QS9CVRsj0cVgtNzTO1M89C+wGN5/
         qhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104386; x=1794709186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZXHYpad4oOt5gixJMV6/CkxNmud5F9X+J+yEsrk7JE=;
        b=QNqJLiBlbstQTi1iYi7ij2YfzifCWiT0mmri10Kasto4n/ZdL3eXFytgWPpPyk1++d
         DMoBvet1NTSKyCgeOr/IWh/aW8/G8Z1rK+irYMxSA7kiA5ER7KByStTqqgCFmKnIYvjB
         tP5J/5yuAw+DVJmIftEmjkwyHVX00EWXtMzm6uEkIZqNnTcYy7+BbtXNEHi1KscOVTUP
         ntyZ9OpjJd7qx4+jLPFLiSmMoqtt9iJjVGGLHcPZNarzuCDue8aKZbcOTlXN9ViEFG44
         P0K9erU1RDCINUtsrG1QkBDVFoV9hy9Cq+9YWn5dmmRqY1PASbxeC0YVQvXsvepCTwYX
         Fvdg==
X-Gm-Message-State: APuU4Z++nuKBKALiPEQG2AkD2a7/pdLhRcZRoyWPAdutGVpO9fp3W5ve
	9nKt9qVLvJWrB0Bccofq+1FnP6z5ttzcyFk87LwPozlDW/e5nMJU3f86vy1L9y4S/NeD9BdOoB+
	WltdwEX/3mYep/4CzvVHUrmtH/jwTVJoAkGkidgbABSw2HAFErcJrIH4=
X-Gm-Gg: AYBFou1Sw5AHXE/mmxUKopmIPUSN9jjQd0eroCFWO8seWGem3BMS3MO5TtfqBJYUm8z
	c7v5qJnynoL9n8Ck6gyX4ajTf518G85Vwuk5d9fR2YrG1CDyddN3WvyRA4zM3z5vCGCmf4I6FmR
	BMrq7b3U8zFW79IsikNZ78Otu06YlFFCMAbivKRdW7UPkQk96+WdYzZ85iA8vWEVGbS+synsAf3
	cdm3CEKoUexfzyRX61zpvebJ8Nb9ZpnY3fOcUaruD+KpdymEN8AEz3J8LbsAkoJlptO3eJZv5gV
	SozjLmlpvK9IeLWiIk+a1Ag6pB67kNbciF+T3H3+apq3GANovMcDIr5Ht4DxtSJUIa9v28axkXP
	LpWP57NcG38MZL9Qe0X8/JQd7BaKvkXtT6mG4fQhsBEzbctcPSEpjB8i3F88ZUjCU2kS5I8nOm6
	p3ZIdNylDxnbPfySqKGQ==
X-Received: by 2002:a05:622a:4d0e:b0:537:83ea:f96d with SMTP id d75a77b69052e-552a20042a3mr4502121cf.8.1794104385886;
        Sat, 07 Nov 2026 18:19:45 -0800 (PST)
X-Received: by 2002:a05:622a:4d0e:b0:537:83ea:f96d with SMTP id d75a77b69052e-552a20042a3mr4501981cf.8.1794104385482;
        Sat, 07 Nov 2026 18:19:45 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e65c37sm7398731cf.11.2026.11.07.18.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:19:44 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 21:19:41 -0500
Subject: [PATCH v2 3/3] generic/810: check that RWF_DONTCACHE I/O drops its
 folios
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-dontcache-test-v2-3-7655bf08d6d1@columbia.edu>
References: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
In-Reply-To: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794104381; l=3596;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=d79UMNtcPxXjVuqH5jzPYBfvKinUpbhjBfuy9JZMPOg=;
 b=2b9j/UUP8DpcmthOzPum0Uz2mmQVW3BRN5foKeG2ADZJciskLpvDSKg5NcEeIeAy9AYvyH2m1
 EBwQ3H+QCDnAUgaO6Re9KCNv5x/H/tXYJGWQxUQ4kdu8jzqi5h8d+lS
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAwOSBTYWx0ZWRfX+rXeq7saipuz
 QZqfdtd3X7BqJLMhEIlRW7V0TOMMYvvXBWYP8B0xhY8WETaPb8I0ccs2GX3XxOrMyTk7IeI3gl/
 9yJ5E/nMyIcxfYHP9eXX83DXHq3V18ng/o+a7m7WLyJqyxs0eUTG
X-Authority-Analysis: v=2.4 cv=YqGa1IYX c=1 sm=1 tr=0 ts=6aefdc42 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=aE_N2tjmDNVO8T2WUesA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: HTxF0yNYvUwgxoLdSkKbF7M6BopDPwn6
X-Proofpoint-ORIG-GUID: HTxF0yNYvUwgxoLdSkKbF7M6BopDPwn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAwOSBTYWx0ZWRfX7Aj0U2BGh2fK
 hybwF3pYfFhadsK7AOF/7jeQ5m8MVIY9yEQYySxgs++f+TPzlmkYFmkw0RP+Wvbg9VMjDwn0XeR
 bIfKMYOx1RiTVOX9zSqc2SwH0RoFlrXgCnavh48Ewf9g495VJP+SzPtLaWKyFpG5WKMlHKgcR7V
 sfNlJEotP05Ccby8tLLwuX6FVIxosBqtoswcT9XZoJMMdv3xv+ux7gIR94oy46Sh60PCMpINjWH
 nHsgBTDDoXPnrqhDBJtuQ55A+LOPKl90rt3Pd1JJtiGapJg1vPn5GAuivC8RSHbPxczkSGZaAIn
 O7pYrtFlCp+V53UoS1dvDehiwqIUsH0AG9Vo88a1MeqQuDxoj9FUB90O/Nyto1lwdVU/Ts9LKfv
 vo67Id2bW0UUnMmUH8oSML6D197zFhkCKIgHDXdc2qkjITS6Kd20hcGapGdzS6Ki+7obBXxU9wm
 OhBsAcsw86weHbhA92g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=10
 clxscore=1015 lowpriorityscore=10 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080009

A dontcache write drops its folios from the page cache once writeback
completes, and a dontcache read drops them once the read completes.

Test this by writing and reading a 1M file with and without
RWF_DONTCACHE and checking with mincore how much of it is cached
afterwards: all of it for plain I/O, none of it for dontcache I/O.

The overwrite is a separate case because the drop is skipped when
writeback completes in interrupt context, which is what happens on ext4
without commit "ext4: complete dropbehind writeback in task context"
[1].

Link: https://lore.kernel.org/linux-ext4/20261012-ext4-dontcache-complete-in-task-v1-1-6ac801557041@columbia.edu/ [1]
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 tests/generic/810     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/810.out | 11 ++++++++
 2 files changed, 88 insertions(+)

diff --git a/tests/generic/810 b/tests/generic/810
new file mode 100755
index 00000000..1866848f
--- /dev/null
+++ b/tests/generic/810
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Tal Zussman.  All Rights Reserved.
+#
+# FS QA Test No. 810
+#
+# Check that RWF_DONTCACHE I/O drops its folios from the page cache: a
+# dontcache write once its writeback completes, and a dontcache read once the
+# read completes. Plain buffered I/O on the same file has to leave them cached.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_require_scratch
+_require_xfs_io_command "pwrite" "-U"
+_require_xfs_io_command "pread" "-U"
+_require_xfs_io_command "mincore"
+_exclude_scratch_mount_option "dax"
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+size=$((1024 * 1024))
+file=$SCRATCH_MNT/file
+pagesize=$(_get_page_size)
+
+# Count the bytes of the file that are in the page cache.
+cached_bytes()
+{
+	local pages
+
+	pages=$($XFS_IO_PROG -c "mmap -r 0 $size" -c "mincore" $file | \
+		awk '{ n += $4 } END { print n + 0 }')
+	echo $((pages * pagesize))
+}
+
+# Report how many bytes are cached, after waiting up to $1 seconds for the
+# cache to empty. Dontcache writeback can drop folios just after fsync returns.
+report_cached()
+{
+	local delay=${1:-0}
+	local i
+
+	for ((i = 0; i < delay * 10; i++)); do
+		[ "$(cached_bytes)" -eq 0 ] && break
+		sleep 0.1
+	done
+	echo "$(cached_bytes) of $size bytes cached"
+}
+
+echo "plain write"
+$XFS_IO_PROG -f -c "pwrite -q 0 $size" -c fsync $file
+report_cached 1
+
+echo "dontcache write to a new file"
+rm -f $file
+$XFS_IO_PROG -f -c "pwrite -q -U -V 1 -b $size 0 $size" -c fsync $file
+report_cached 5
+
+# Start each of the remaining cases from an empty page cache.
+echo "dontcache overwrite"
+_scratch_cycle_mount
+$XFS_IO_PROG -c "pwrite -q -U -V 1 -b $size 0 $size" -c fsync $file
+report_cached 5
+
+echo "dontcache read"
+_scratch_cycle_mount
+$XFS_IO_PROG -c "pread -q -U -V 1 -b $size 0 $size" $file
+report_cached 5
+
+echo "plain read"
+_scratch_cycle_mount
+$XFS_IO_PROG -c "pread -q 0 $size" $file
+report_cached 1
+
+_scratch_unmount
+_exit 0
diff --git a/tests/generic/810.out b/tests/generic/810.out
new file mode 100644
index 00000000..cb6c3f2a
--- /dev/null
+++ b/tests/generic/810.out
@@ -0,0 +1,11 @@
+QA output created by 810
+plain write
+1048576 of 1048576 bytes cached
+dontcache write to a new file
+0 of 1048576 bytes cached
+dontcache overwrite
+0 of 1048576 bytes cached
+dontcache read
+0 of 1048576 bytes cached
+plain read
+1048576 of 1048576 bytes cached

-- 
2.39.5


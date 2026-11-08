Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104392;
	b=S6SNgtOn7QMdbkLDrgVH7Cjqm/f5vkBO9iOCU2lPVygwn2cbyz+2N7ot2DGs2w50O2sO
	 JYcJRNhIVW6kWXUr2CACBgbWT7H1dXZ8wlkx47J6YaSScTO+hRPQzV5smJZzf73TGTUAM
	 s9s+FFhqBvfJgVxAXEE2V/93plLMKEHQqY4nlyD0xrM/CTWElS1EbdteeetKk9K7XtR76
	 d0Yze6fymqLoI3Q5AmJ6AEab6XaynPj7U6D1/ULsHPxM6gm6uvrlo+2C/f+ayoIsA9f9x
	 mKHujJg2BReFAV3Ik3B9jMpithpY9LY+r5bpvlbca6ObcCQBRMqreTcna3Tz45XkgoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cCdrrxx7mhDNtuHXVTKYbLje1iTXY6HrNZ9671EV91E=;
	b=Iu2DaBEAnNmJNMuLrfJ1yH5I6WBWh571ppnwsfH5vv48wKDwvjFZ7d8hL46FwVtKEzNn
	 kW/TojPny3i8SaHqjzHMhU0HZXUtlNSFoTs4qF/hLpjRgsy4dYcDVLeHovGgOxFwFUcn4
	 ByOVsRHFERXIdQdSk765C0UKUBAEFLUW3uAHdKnhpb5yQU7Og18Em+qYhI2I2S+phZnP0
	 jnti5vffHYb8F4rI3LRRgNfg79SVITAMe8lVM/jfW9XqG5XgytIUYBoHmQiDqZltN/+OU
	 1RaE5xYIKRrYlIxUOtU9NmCEsHq8RezgpzjhI2Tvhu8J6KkxdofEK4+lDyUVlVlHQMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=cL7EFWth;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=W0n9Wuhb;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801C606A31F
	for <fstests@vger.kernel.org>; Sun,  8 Nov 2026 02:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3801C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=cL7EFWth;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=W0n9Wuhb
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7NdWRl1411349
	for <fstests@vger.kernel.org>; Sat, 7 Nov 2026 21:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cCdr
	rxx7mhDNtuHXVTKYbLje1iTXY6HrNZ9671EV91E=; b=cL7EFWthlbV0AsCq1cXL
	4XtPz2pXol1EcfsuAYG4BOE+jldqt6pWv3BjUgT6bo0Rg6YnhHo2LRRWyE16HPdJ
	9fMcQNVowmgGUy/4gObjcLywe/PMT2e59+arLa0AvVz4JoA/z8UwHzIjMcGYQ7XZ
	fe+Gl+LU+2hu2wamm+MMCzepY+TeE00LATBTfFJgCSBIY+C92tSborkbgudS5wLs
	S1W/MF/W/fjm/aQsSKSHtNUpefLL1CJtmDyBMUxUUsDmMZ2iFiXsGp8DKPZL8nS2
	zUA3rfa548R/VcTcjkXpLkOTm+39rO/zrEs70mjmv06W8siLtFYHIHyFQjSq0/k4
	aw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hsxev4074-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 21:19:45 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337f26ee19so2182201cf.2
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794104385; x=1794709185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCdrrxx7mhDNtuHXVTKYbLje1iTXY6HrNZ9671EV91E=;
        b=W0n9WuhbZi+p1ustNkNv0hbTZRs13aOkEuclRc5Ot9rnIpf65Slaa+fjLUeS0VGrf7
         bPdeEYZ/gSagRWEaY/aciIgHUpLynhGjjSzStj/fcMkzeOtfUuurR3WUaGFGYri91D8R
         dRfmbZsvv/B0BJBYTC7b74aXGgFJmWDz76+DAo9dKXeDL5eWcHzjVLICmENCssJfSmsd
         4C5QUx92Gh58diExoovAilavWBOtV37tKZeDsKvV39EwLM34lgaJ5dEeZ33GnkFR8xGO
         J7JIyEviu5h9tJmugT/bQSFsnKzOPGNUqd+QjGKTPHSLRCiZPTbFSxkvor2Z+6/w94Hd
         pbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104385; x=1794709185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCdrrxx7mhDNtuHXVTKYbLje1iTXY6HrNZ9671EV91E=;
        b=bF7oW/9pVaX5g1l1bri/rg+bUnhczp9fFZJggKcdjg0yFTxL2xEVfuwLQSgXhsCJbz
         AZ1e6doSFmFKTntBaciL2mqVm0aHllla70xvvXFhkb70OPZTklASKrhsD0lboy1CW71r
         nmx3yjLjg1ib96tBCdq5igQ3/FtMwgU/SWLgJ5RsyQO59mFbMXxV24b6+CJ4/F8TxqAH
         QD36VtLa5SaoBlYnTG3FXoqtXx4j3jxKvNqBmGmR0afq4wuk94h46S1SuK57mG2PB5zS
         rtY90vDJTXblRpuQS4RHtg70VA2cX6q07ZevF5PwbcH9OvkaXKXb9TH7b+i5mIWn5Ltq
         BGBQ==
X-Gm-Message-State: APuU4Z9V2N/MRAVgOVwdUPXPK7zMKLySO2eCmMCj+DZdjmDaWW5p0j+a
	cVWy3SUX2KGvsNOQG1/QFbmJottG7ww+VVK8EW92WqKBH+j7PjjwYRs/2jbgf7Ubwgyj6ZT8HBU
	Mdcxkw69D0KYpFQ9RANLvFPzzFs5T8kEt5ycub/KIaFbtji8/3ODzFlg=
X-Gm-Gg: AYBFou2X8cltGL1BKN5R+6P2WjTPgGmbvhPNClzhzCSiwgktjxSFxT8hwgv6aEluxCM
	djiTXQAEKJPqsrl98zsAx7O3sVFZHwU5TB0P/sF6p9F87AYIKEW42YW+BmXQyvASVld6kHN8HlE
	+3M9HQmvk4MllxuilxvSljY5KTXiEodeAHyZBIU65qfqN7uh/aGYSZDTDe+rtA50a4bsjvHmMBG
	vrnMeyrsYBqSoEzhUyMbVKpHgX3vIedwqwCEin2EtuINyagZ9EA5O88H0yD+HGG6YvmKpRQfff1
	4YSLVioQOjdLRAEiN3iFzJTL4D7PSm5qzrNMSn8l2vNSStHpEm1BZcjXEXuBGd3EPRi0CUG/RNZ
	8GXXgrOOgdN9fxox5jeOlxwH95DkyYqMFwPQ/uqivzIUNAKNjq38tdLAG1H/3MdYms4ME+wnZUo
	+k7MKGWbRWzLTCHjbC1w==
X-Received: by 2002:a05:622a:13ce:b0:534:d369:f398 with SMTP id d75a77b69052e-552a5a71827mr4424761cf.41.1794104384979;
        Sat, 07 Nov 2026 18:19:44 -0800 (PST)
X-Received: by 2002:a05:622a:13ce:b0:534:d369:f398 with SMTP id d75a77b69052e-552a5a71827mr4424611cf.41.1794104384617;
        Sat, 07 Nov 2026 18:19:44 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e65c37sm7398731cf.11.2026.11.07.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:19:44 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 21:19:40 -0500
Subject: [PATCH v2 2/3] common/rc: pass -V 1 when probing pwrite and pread
 -U
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
Message-Id: <20261107-dontcache-test-v2-2-7655bf08d6d1@columbia.edu>
References: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
In-Reply-To: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794104381; l=1379;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bl2XVOU514ZVTDOk9o3rGSu3PXlMZ7AH+3VsW9sOo0A=;
 b=a7hotu4mJZ5ra8tG+YPWDnJoODG5oPGdJ5UucsopP1udghS7eYUZ/LI1R0SDgzY7LT7EHJhI7
 8UzAs+fHuq4CbWQkFWskHfgsBBsuQb0f51jbpbYGuIkyo5azxdGjkSj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 4zBSp77LhZfUpBkzv0wJK4lhs-BDBwdM
X-Proofpoint-ORIG-GUID: 4zBSp77LhZfUpBkzv0wJK4lhs-BDBwdM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX5Qxwo7AaUk2s
 UXe5apQj4ZvU9WjC+xqR7+oWo2hv6ekBg/GddjznpCZCjw7NScZt/b3dg6EWUpudejixUz1pZW3
 pLo0TV7d61ogHjMvVPP8SqY7w/1KyVnO61wR2Bc/ieOZ25nyn+/LPBqaa6YMJ2wt6IBgMd9nYgc
 A9aaSqEQ9xOFo9zBSdMGQUk4gj+tmLLV2p1fSjWVffu5/HiwVTxFe50g34fI0yhywBGsLzLxYwG
 QXaaSXzj8FVAr4FKercGn+6YE2C2wLZVFjWgHS+ikPDG/GSYswYrfW4ChLJoecf68oRF+HNFLFS
 At010g/DSiZSvaMUu9DFAD/unMYbkZnhT/L11sy3g7/D6GhcJvRGNk3B5gtXjtgNLZMFVMApIH/
 2QFAoX1OK+ZnJy4ryBZF07gE4FxkNtnG0oDtc7NdkBt9Ga8hr6Q87Vp4nYF1dRGBLgk08bVCj8I
 DdfGOEorG7Zm1CAZNGg==
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6aefdc41 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=20KFwNOVAAAA:8 a=DjKFJ4GTv1yLP1aJ184A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX524b16pHyQR6
 7G/IUmR9oOpiqPmx9H2o0SVz0OJFQrpsuBCiW9uekC242CVvrgXN9OnXqKquSKTnM+uObssoh01
 WoT7MiRfNGJsf6KLKew6Lp722o8PXiLBlG4/cg/oND84E0sL2EXg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 priorityscore=1501 bulkscore=10 malwarescore=0
 clxscore=1015 lowpriorityscore=10 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080008

xfs_io refuses pwritev2() and preadv2() flags unless -V is given, so
probing -U without it always fails. Pass -V 1 for -U in both the pwrite
and pread cases.

Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 common/rc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 945c9e42..a0239034 100644
--- a/common/rc
+++ b/common/rc
@@ -3105,6 +3105,10 @@ _require_xfs_io_command()
 			opts+=" -d"
 			pwrite_opts+="-V 1 -b $write_size"
 		fi
+		# -U (RWF_DONTCACHE) only works with vectored I/O writes
+		if [ "$param" == "-U" ]; then
+			pwrite_opts+="-V 1 -b $write_size"
+		fi
 		if [ "$param" == "-A" ]; then
 			opts+=" -d"
 			# try to write the minimum supported atomic write size
@@ -3121,9 +3125,14 @@ _require_xfs_io_command()
 		param_checked="$pwrite_opts $param"
 		;;
 	"pread")
+		# -U (RWF_DONTCACHE) only works with vectored I/O reads
+		local pread_opts=" "
+		if [ "$param" == "-U" ]; then
+			pread_opts+="-V 1 -b 4k"
+		fi
 		testio=`$XFS_IO_PROG -f -c "pwrite 0 4k" \
-			-c "pread $param 0 4k" $testfile 2>&1`
-		param_checked="$param"
+			-c "pread $pread_opts $param 0 4k" $testfile 2>&1`
+		param_checked="$pread_opts $param"
 		;;
 	"scrub"|"repair")
 		test -z "$param" && param="probe"

-- 
2.39.5


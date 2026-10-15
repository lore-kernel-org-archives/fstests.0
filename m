Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65035494801
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097800; cv=none; b=jqGqfjf5JNJ8vjbnNlDrlNCBuppqwmGlpoylTQG+l+3z6F/kCVgC2pYuv3mzKWs/Y8qbhMkOyOMC89Kd4PyB2Okqfj+r2hFULAiZEhEaPCvDOSlHn00lP6+OYCuHwClxdxhDNwx4JisN2N8oNj4tQEQOyhKcYl49Lsnx1IvSVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097800; c=relaxed/simple;
	bh=KewLqlkj9HfaC+aOJYKAu061lljKKowhtkC9ghOwU38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrRhGiFyEmLTYi77/CzJmlAwd6iRofIOX2YMxi4J2gO3KK/V5oOeEeW8lvTbf25yazxSjge2446npDkoplfQ/R5ocLHGgPPX47zXuEN/lSRRfVAILXIpmWWsgl/3FX++hocXzAaFqHAhvkuWZmCBVru4PCK+TTNJ5bz8hqk6+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GX5gIjGP; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=JcTXeW28; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GX5gIjGP";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="JcTXeW28"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FKaURb1569077
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=dfSs
	h0cs3XLj2wlU1kGst3AnO7cgcsSohbFCtj+DeeM=; b=GX5gIjGPRc+YhDVJlK07
	8iRgH3cWRzheqRoQRLxh+Z88CkXiyM0/RzHeTwEk2XtiAZedp7HLqpawtsi4zGpc
	/H+++IIaFE+WaKrDSh2sLFg4ALTkxjH+I96nXZtZ7PcYizvcB8koH9EUX1GnhrPM
	Unkx9pGBTVqgwZy0HFr0pTAVlVaBDoEijfZi0aPRchL+8DTN1NAQ+C6hNKMP2/dw
	jE0weC+dN8TkZZL9HsfchNxzqU4+LEg4VSpYS2QBFrjbc+n0bjXUbYM1M5OqCDY8
	xXUb9JW2R9iGVlqwbXckP0dt9tH2tAfw8J94v5/lqHIvDGeuY0dNzDp9sA67/O56
	yA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hb2mua7qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:23 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so385298585a.0
        for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792097782; x=1792702582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfSsh0cs3XLj2wlU1kGst3AnO7cgcsSohbFCtj+DeeM=;
        b=JcTXeW28sUP8lbCHvaoyZoaq2u9/VYez4O10riNicexgp1ICAp/r+/yINSfFNnZd/n
         OP88JsMwO4GkVe61cJxMRqE1UTmVO/Gulj/M2s6MzLVC0Pq09WavgyKJTCnMT77z0Lcu
         cTs0zesKerNYSP2jQLZR+1gNBHDKWL+9CblnSLDVEwTDtCdI0QFsjDuv6+ZjXTiJa2Ia
         7SYD4/9Skq/ZiV5FeHz+pNGH/dYE5stLofpaKHe4F7PnU2B8J0CBWF+ehnNd0ifw4LRM
         HJ+t0fU50M/x8KaEN94IcrMcoQ2z3yFl/UqxknVRHEo8QAuh232ynvM72ZyvOkRA7hvH
         Gg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097782; x=1792702582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfSsh0cs3XLj2wlU1kGst3AnO7cgcsSohbFCtj+DeeM=;
        b=PldzOSS2nJFAgyPsoGcy28wFJU0gdns9k4Wolgi5nCv5LlZvej9TKLyalihJCaJrc9
         0h1VV4aXVXeQtlS8Q/EaCjniulCP1kG8s+VnifDXOMGRZXlR8/XQTy+mL3WFgmCa6dL4
         grCM8bRuOEbJIxliTgGoMfwbw3l4Na7mX6AEuBXvTjcn/7lI0mQpTcYVeiZkT7JGRpvX
         DXR4TD6uNe88Wcq7WKw6Tv4Mnj+/qy5LoXBb54Pf5DKc7FVQr63Q47yBhQXzkQIqt23i
         luRoJHVoam72AG/XYb/D+uyRtNVoHZTdkbj/sGuYNJzsvq+qf4zEpqRahJoYGeE3F3ln
         qqug==
X-Gm-Message-State: AFq9FYIs73DD58gQV7AOuisU9+pnPeK+KsJjgD2XmsilY9g0xYKkNT7w
	XekFNx8T6CkwutVLW+Q/otvJXyG/TOz9RSAWwTUDsM5saj79TYhQPQ8Qxp9u5c9bUWOiIcLqJii
	Y/m4+T+KfcaKI4j5hTwdTIScaBlpdJrTBKA49q0u4BPDpVn6Et3ttzOQuwRa886w=
X-Gm-Gg: AYBFou1/kxtKWktFxDEpZKFFZGkMgQcIXQPspU1BCup1V1wGkAqlDHwx6CQPWEDWpJQ
	XVjBsh4tDecKbhWC/Y2MSKeURa9+AOHz0Q0v40EXVcotxko9W54nohd6EkSMI+gMQscK4z1QSUi
	dwKL3D8ZVfVYf+fsNZtc7dRXkCXqZ6cAPEfMlAyRcwetTm7UK20h4SIfEwX3bZb6vhN+B/0SVw5
	ZiA7MMcjZ044kax9VuojHmhzLVb5Bo8L98FC+qerIrehndgbYNmGfekB4E1hxSXW8zMLQnH68+q
	b2jnKTeidC/FvmhH/HlJo4aE21s5/tHjwW6ARZmJAqtbWMt2QWJFRSxtpKNdDBkjsojUc+D1rTE
	Jiw8V8dzO5nWQbepZvM6cdZrUTZeBMRtYSr5CDsWfuLHI
X-Received: by 2002:a05:620a:c50:b0:914:afc1:c66d with SMTP id af79cd13be357-93ebd0e4d5bmr3487233585a.11.1792097782376;
        Thu, 15 Oct 2026 13:56:22 -0700 (PDT)
X-Received: by 2002:a05:620a:c50:b0:914:afc1:c66d with SMTP id af79cd13be357-93ebd0e4d5bmr3487230485a.11.1792097781953;
        Thu, 15 Oct 2026 13:56:21 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1d1bf6sm29062485a.47.2026.10.15.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:56:21 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 16:54:02 -0400
Subject: [PATCH 1/3] common/rc: probe pread options with a real read
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-dontcache-test-v1-1-6aa7583973a9@columbia.edu>
References: <20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu>
In-Reply-To: <20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792097779; l=965;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=KewLqlkj9HfaC+aOJYKAu061lljKKowhtkC9ghOwU38=;
 b=WSyRU2SY8Sew3m9bOIxFRL9FVHk1D0DpCPckLSn3Ls6NVlmM092jU6uF/Rn+8mnHV/Iw+8ZVw
 TcG7BbWA2DWD2aJorUG1m8LMvUG49aRvLHuYmIG+e2Rii2gADw8ObAc
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfXyw/Kvc+U/JWL
 N6EWAOVaGdwimnaB0YFgqMeeQTRbqDFRR0tePuPgr9DW8NmFQKBLPP1mbLSOUKityuIvag+fKFo
 evWmbTHqFM94Twn0X68SrNpp6JbJvS3qO9tho+Ettf4HWrZpt41i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfX8GP7jkHLTVRk
 jVQ29vuUa43SGg3KP/oSuhBdJrntIvFEqcmUo1HQ3Mui0BQUJ+QZfPYBz8OU0Czbb4NdHEb3C4s
 OJBSKaeLXcxGDF72qbxSW++r8hwAkCUdoXlNYo7f1nq65nivfypkVib5oMaCjZ/mPGU158c2zUJ
 8VLt43UKSPQicT9yHbJTNxBSNDwWgxDmwM1aqFaV0imqwXFWhodHZdbd5nGv4bZp5D1QInFI2qy
 x49LUVMHOsI2iPd0TagavKqxFne04CgZ27uBYDc+g3HK1/geJxHnIiAVp5iJl2QcZQgwiFMuUWp
 u2uVB+m0DbQDD+2axF1BW8GMNdkNiS0DlTgqb8ICXn0zQ/mz6cHzPqZzKjB8lCrEflon415QelZ
 gKTJrMiVECCvR5iVPcTedmDvZFbL3rVBw5t8hFDeuSsIRXjmhBqjh3QH9u9mczAIFSL/LBSmf7W
 n42zQSP5C3OzuYCgbpQ==
X-Authority-Analysis: v=2.4 cv=Z4d5j3RA c=1 sm=1 tr=0 ts=6ad13df7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=zozjgnHnxDr4c7FHEr8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: D7RZGWWVFhgIIkEt8uN7z3f8VkTjCvEq
X-Proofpoint-ORIG-GUID: D7RZGWWVFhgIIkEt8uN7z3f8VkTjCvEq
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=10 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=10 spamscore=0 phishscore=0 bulkscore=10
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150083

_require_xfs_io_command has no pread case, so a pread option falls back
to a grep of the help text, and that only matches options that take an
argument. A bare -U is reported as unsupported even when xfs_io has it.
Add a pread case that does a real read with the option, like the pwrite
case does.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 common/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/rc b/common/rc
index 1eccd60c..945c9e42 100644
--- a/common/rc
+++ b/common/rc
@@ -3120,6 +3120,11 @@ _require_xfs_io_command()
 		        "pwrite $pwrite_opts $param 0 $write_size" $testfile 2>&1`
 		param_checked="$pwrite_opts $param"
 		;;
+	"pread")
+		testio=`$XFS_IO_PROG -f -c "pwrite 0 4k" \
+			-c "pread $param 0 4k" $testfile 2>&1`
+		param_checked="$param"
+		;;
 	"scrub"|"repair")
 		test -z "$param" && param="probe"
 		testio=`$XFS_IO_PROG -x -c "$command $param" $TEST_DIR 2>&1`

-- 
2.39.5


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104393;
	b=jr6SzjsDeO/JeMDmbosqNF03HqtzfEJDOjxhpl4bTLX0R+53gB4fbL9aGolJPSGjWelz
	 RrdYH3d4pLAzgrny6n3EE8aS1MGjEu42pqIq2HIkbW1HB8iie38lzCW4LPIZa07ypb/a0
	 MAs0qmc8stZSMricWMk9e1n9pd6gRLsfkX4Rf7ilaB7bevapZVWnZLGoBezbgdQwtj2tA
	 206JSEPLL73Toq0q8ozTdfXORVTSIq/AQbihlQeAq5oKz+JzjVqP0bN4xFzV7bNR8MKON
	 Tz5k2zdQC9hUBKy9l/U0/7bHkI+YBDtpizOIqP7Y79OXpvdBObUy1jOxKvHu1w/KeUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sCMq+RfBZIbc6QQFaznjLDgyO+p8lUR93axMHEZIRu4=;
	b=YpQkBMcbSOFqUzQevmLdxU1MV4kugV8kTR7P9U29sZ5V74VbszhjCvMSnRWuxazGm/8A
	 bQ7mRtxABANdTq5WHpi/caVW4R6HVNV9BgFzvx1W8y95Tbx8gtAsXWRIV/0jdyaB32Ruo
	 q6C6+hXSp23gxdf3W8wRkR1860z6zlqM+IyjjY6iHuNANsNlNzS9sCnQPfGU+ApMfyAKM
	 W4HdFFoGLu3Kn0hOmSgd7icFEf5N+UjAdN16SmBnXFm8t/x9JhjwSaPchjyCiYaYFGhkh
	 n/yihfWfjacSkui3bZhQlVDG5VDrd4r7FHv5TQ4QYX3h3xOnDPjgNU5btziz/UisyKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X+FHg4R5;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=B6PZJzbS;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F41606A31E
	for <fstests@vger.kernel.org>; Sun,  8 Nov 2026 02:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F41606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=X+FHg4R5;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=B6PZJzbS
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7NbWDe1993375
	for <fstests@vger.kernel.org>; Sat, 7 Nov 2026 21:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=sCMq
	+RfBZIbc6QQFaznjLDgyO+p8lUR93axMHEZIRu4=; b=X+FHg4R5oYjtXqRQJ8jW
	OLBKAnJiix3XTBKSXRe8n1ldf3a6NTAa/04VuTRmlNYODuBMlqZ2mUdFj8jT9Z+p
	riqvXNP1/KtECb50a8AsmyuCZH0UpmqjQ1q8Bbf2wbhqXjbCAixq76E5gh/MVtaO
	5pIz+IPsAewfD6mlLDtFG2VOtUQBhZACi047BtUMukxvHxpbIXNDR0mmxn7QCaL4
	NRlBsHHze4E4hYmX4UgH7UgrYfyK2fF7BzMYEI6/+gDJdaAgdETFlcEWNGOPYoUe
	KyrKdlPJRGZjV8Vfjol/+kPoGgl35dgCVIrw6anRl7O+NNKOACbeWOH91rPVQdnr
	ZA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ht0rfbmcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 21:19:44 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b937ecbb4so2509416d6.2
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 18:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794104384; x=1794709184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCMq+RfBZIbc6QQFaznjLDgyO+p8lUR93axMHEZIRu4=;
        b=B6PZJzbSHtWiMcxvV0XNZNfeyxmmDAKrV1V0m2HzPNsyLjbwV01eZlLAOrE2+ZHTtP
         pblYr3qMHH7OfDOy50+L4xEnGHyisGe9iZRZ/1QgphyGCUzWBfXf5n17dKBZTnn/C9i/
         B5rfoOfBkNVndIChtgSAMgCFf3yu9nNJHwhBVORXytUx+DKeUoKO+h5Vi5vczgINf8fr
         91ZqKDzTIvoPD3Wp0i5HuWaGFfpxIzWdFoLxqvbquOSEkBPj6Zn3JnzmvZDOn/I2ixyx
         ifmYPzYiJ5RhpeVN98zq/tKmThHAs6sHW53Zb/K731G+RDiNGGqUD+sm67A8BBkT6DJK
         5QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104384; x=1794709184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCMq+RfBZIbc6QQFaznjLDgyO+p8lUR93axMHEZIRu4=;
        b=johW29okNpQ4LJSxPivhdQaDvwoSapOfTykKV2LQRLzLQeOsBlojwe9duB7TNL9tvs
         /pYemQETc3G7aIY2A58A81344DBlVOt6nTlN9N1xFIsPkhyl3kyczjs3w3ivn8eSidJT
         oNYIHgBsS2Gxu/aGZ54EWhIz4/7UKV/kUqmWn6w2h9TWsirkoBi2DHe43KwT3UT5y2Z8
         uNu5TWxKfwP2IG5jUEHlCVtiBYIZiNcO1g+3ARThX47pfeZw1YGDxj8gmUlvl226XjmC
         dheZkS5nQiMNa+Ag934nKhyt6ejB3nuh+O5dt1K9Wcen0zgt8FZJZWEFzxPMxFWKM2WS
         LhGw==
X-Gm-Message-State: APuU4Z8Gi8y6v0v5GwIhAwgtegEG0o3eXe8Ehjfd5Ku1cI5p6pII5VPz
	ih0JCtoarfsZ3EC5WSyPTW3PbflKndeuHiYNhhLve87hOwsjZCj8x6eL2fuBXl3p1rTgm1+Jhum
	hJjv/pSWo+4x+VwA3k69nwxt4ZnrtgjgZyim8LbRv8E67MT/dxhNpc8g=
X-Gm-Gg: AYBFou1W6d2RzBmpPgS/sHd2T0wfHgxxtDx7NrcOXHQst695h9K0WlrXcOsI4TRYvpG
	Ob8rWZtYsTS+Ffp0/z9PME8rfkwp4u0Z6MdAtV16fglYnKkduxaey+REUbESb0TZtNW6/+r3qRY
	xtGWL6FNVNP9UgqfE9yckQ6qEX4LDeoi1ihBx8+Pt10I5osZ7h8eLgDAxfl2QFY9geHVCAO/zjF
	9yBMJebSrExut/bIkut+ZUF5SW9QCZV2Rfy36+QoKQ5mGdc/Jkv1oiJNZt2lDhNBBYF1PDSqeLu
	uzjPQOFb3RGb3Q2XC7jhPohhgl+tdo3nS8daXdOwo1ZozqKUWB1FBNzapqT/QT+raWc2hEeCMy1
	hH5NJtWSH+m/gOqKOplnTcUYfhP/16Ajgr6TYI1/wTgE751jcSgGOQGoMcuFnQiFED5LKXAW7i8
	c3D0L5zhJa7Zc4XsKn1g==
X-Received: by 2002:ac8:5f12:0:b0:535:856c:1241 with SMTP id d75a77b69052e-552a578c620mr3906951cf.56.1794104384071;
        Sat, 07 Nov 2026 18:19:44 -0800 (PST)
X-Received: by 2002:ac8:5f12:0:b0:535:856c:1241 with SMTP id d75a77b69052e-552a578c620mr3906881cf.56.1794104383662;
        Sat, 07 Nov 2026 18:19:43 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e65c37sm7398731cf.11.2026.11.07.18.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:19:43 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Nov 2026 21:19:39 -0500
Subject: [PATCH v2 1/3] common/rc: probe pread options with a real read
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
Message-Id: <20261107-dontcache-test-v2-1-7655bf08d6d1@columbia.edu>
References: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
In-Reply-To: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794104381; l=1058;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=g7wMEEH7lKhR5wDFpgsEHSduxWWwBO0YYNK2JcBk7e0=;
 b=ELaVECtALdtYDIJTuF+pWwmgCmyfVP2vXqXMs1wcRxui1RKAXtYVF6oGBXKuAIWzymLecvtIn
 ssvsWcHtXuwBqGDE0pthMbZqKyveqOKeCetQ8xrydtkZvVvVjpQONop
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX/mtancEQ0Cl+
 yqnwojXKdRvYEHOFa0qUo4H6IHKvBJD0ps+9tt+viR/AakS3YelwXJdup4vLkVuN2Jh7vT6izns
 qBXTdQOuQROO2Wje5vBfG0dfrfIKO106N6aPJUxfVcBhVatTGggmaw5SAxDFmyAyA2rbrex6had
 GLQpIvIO3LC3AYBvXEaXjYi45sFVb1wZJKxJV7yhK9+lDx1M3HPoxXUfAFq799MnONabLUl1ArT
 iR5HSJm+FOjbgGHKNiKFrs9+dORANwYdbxpj9IPzUwyWBSgcnKCcDVsZRK8Y7UqI7xZEjNwrkwe
 ta8kxqJkLvP2IL9vkEAydCAFRGxfsmgxjsPlr/DqswLnbg3awV+rBXsSEn+gTEx5yttmsSK4MxB
 U6+JDC05+sW1i+x756s7wCChmGyFL7EzMKi7SkHi8pfozhQu53KIJjw2OwfFQcS6Ux6En3J+QnH
 Ugd6c789SCh4IUQeZgw==
X-Proofpoint-GUID: IfgAmsKstYkcbq-8BixZO6y3GQJHqi_U
X-Authority-Analysis: v=2.4 cv=P+ivFSAu c=1 sm=1 tr=0 ts=6aefdc40 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=20KFwNOVAAAA:8 a=lXqyDxuXACF71vQqlpwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: IfgAmsKstYkcbq-8BixZO6y3GQJHqi_U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX1sEAHexRhudx
 Rjd/8qXfIjI6BY8/D7bRG9pN6v8f8yaCeHtYNORT+0i+Bk2qcpu6vHKHP+59Cuy8navgcMBU/O7
 W3JhebQNRtKA4jGSu/+l8kzOug1G4lNR4kzKf15QBveBtK4w4+QC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 clxscore=1015
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611080008

_require_xfs_io_command has no pread case, so a pread option falls back
to a grep of the help text, and that only matches options that take an
argument. A bare -U is reported as unsupported even when xfs_io has it.
Add a pread case that does a real read with the option, like the pwrite
case does.

Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


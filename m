Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104392;
	b=tDwAIK/v6xe/Er+kbXdSacaMjgH2uCUG7BqYPNL8Y/i815MGrYvTO/yY3IusibCanKsj
	 5D0+DKvsXNEBvWTI8cX487Ax1W9cGTNJT0fWxiYi42gT+/j6rkXSKEeyqisV+aRYgF7a9
	 3z8Fn7FKmcK5Y5B3jlwUX12DuYYll9HuQiUlYa55R5I8ZD1lnkBH2Bl8FLOcht4oWRUSC
	 gZ0e5aWIoQiV1U8JuibScqGGHw/8oyKvpkzrpl7P1svBNc9XaYMfPJ5M/lmYD0Mie/+X1
	 ZlsymYRQILMQSBgchinPPJdOmIbh2059ScUOHoDMxtNNIDjKFaZsTDa2ABHJCRebcaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=whgMGO08w0bti6oHmDssbLwFbA/tph+QoSDdsYvM5SQ=;
	b=H34qoRAeTy70CKCQ1iKwWa/YtMDe2opRwjocrQj6SH5smPK672p+5RAanl6e6qK4W4hU
	 7w/htaV2Qg72ClToq6xDeqHoI76abbScOBD9XNVW3rUD53RDI7VtN4rg1K4SqO889In8x
	 Zq9Anlk+v01ejHbx7w7wG0A4jmHPbGUFAzGqbY7n08qyFwR3fubJXW4+JPw6TZsIFFagN
	 O7b1P/AdqYSQbFV0B56YBLEXCxqjULAZmkNTYj7sabkx25Qzdw66GcRDUFdTcB2ZhHtvB
	 oqIrwnulLn7Tbo3i5NOm1U59VZD1Q/5oPrI3hP/aCKbhOLcH8N/9klkwSfN9uY/nU/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=TSHvCuHl;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=c2W59vAp;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F9606A31A
	for <fstests@vger.kernel.org>; Sun,  8 Nov 2026 02:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C0F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=TSHvCuHl;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=c2W59vAp
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7NbIOQ1730580
	for <fstests@vger.kernel.org>; Sat, 7 Nov 2026 21:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=whgMGO08w0bti6oHmDssbLwFbA
	/tph+QoSDdsYvM5SQ=; b=TSHvCuHluZLbe+ARxX/LUHN9fXLeiN+Dn+3bv/W8/N
	jkFc1Tcktu7NR91Ohrw/u/3263BeXycQ6Tp/i/A6SI+4CBG4lKx3igHjrPc0d/bu
	N1uZInkHRxuWTnaXuDvoZoq9funBIhsMBnTVtxhhEdh2U9nkDv1QUb5HaxfQjCQO
	sAJ9LPrWgYNbxXPCo1LiIp3dKENcrk8yNOp7VO4zxGICCBtM17MBI0w5B72xF7ku
	wRenwNaClKmT9TvIYgC2qaIMQnjBNOa7j1DYdTUkPAJhrkJHtq+Wya2CCOLlDNhn
	Wcl4Ujoz5Dy0pDALyd9luwkY9J4hhLU1ARouoWdNUVVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ht0ur3nb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 21:19:43 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-534f3fe0236so4204841cf.2
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 18:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794104383; x=1794709183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=whgMGO08w0bti6oHmDssbLwFbA/tph+QoSDdsYvM5SQ=;
        b=c2W59vAp8vrzW4Kf8YZnsNQG0BQg0Yn2OhT5YPcbEe957YPvaq01bSF/DxAepzEHLr
         L5Tvu6EePI9hrR/Thod0nK2tTLfUybTq4BbyUkJnJivDnWUKpn9VC17xFg75uzs4WZlh
         0Y2oR9yfC9SZRrLWxERcT/wX1BSLISkg0qgYkmWVe+gaUqRgZ7YQOc3iYHJWJTIFFAaF
         CdxyMlPdpiatHzjg2qCWAdQ4hx2KfZ/429jKKcAIQmEwY0aMCChoOoRbTqP5ssmmeVlF
         aBuNbDDYJcjfs0ICjcDfAqRyLRZtmz/GTImry15cpjQiNrHOM0qBtsqAxsrCoBePhizF
         PV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104383; x=1794709183;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=whgMGO08w0bti6oHmDssbLwFbA/tph+QoSDdsYvM5SQ=;
        b=vA89JBhV43fzH1UAkLBFHEm9DJZ6A3sTbeB/TnKSaPmFHfHzihvzO45C+exv5di6P+
         IUsXOq+kPZlFV2sCADKqO97WJZT92KUV1SWcagcNstZlL3W3quwhyB+iSVF7SRfThWXh
         F8EPtKGqI8m9ofKFCA/PEJg8+JCUZGjJfNZ3Ty9M5TVOQf1X7G7WK2t/bmKNo7TbMnLt
         GKXKQMQKPQqNtdpzSjYe/7ZSWkbndrpzfm22YL8EQ8YXTbfaqcEltnq7/G1FPeq21n4d
         tg7I65BZ2oDyC/MMd7Bhdm1mEFpNRfeOMGTD0bWFrSxzRa6zyWyhxdvT1lYpgSahELBQ
         y4zw==
X-Gm-Message-State: APuU4Z/W5+KcligQsNE32+u4lgRn6EcsWFiPgGriXt93TzKlrBxd/prJ
	Ias1An3eXPoAWUijWMbuURz/lCk7pYImachgJN6rrlZEd5TA7HhozDYh7nMbl71aegxRXK4b8TQ
	2FyaLVhlQRFvXMOCELdMso0SbDDiXPQveh+waHTboLnOKXVGnrsTsczo=
X-Gm-Gg: AYBFou2sIfi4zhFYTpiEMJPICZ729L3SrSUGUsbZCIWxN7wM3PYmGRUKXVQ3Ft/zJdG
	BCXWLTVMP+2PUaUBfn8oJq0tOaNM0w5Cm1WLV3dHCOSxm0/lGuKPqNP5hpf5Z7Vz+x3i0x8Egxr
	Z8osskgF91Cuthy2YXAuLYJzmW0L5Q1R0cLp1ASKMPjsOqd2wxtcQNkynC3S8zUBg5KUV4gszLs
	PwRTdXnBwna5RGIJzHsTtLphXMZpntSUpUg6Xx/QxykjczRkxNGRHDFI+ouUx8FKNo5LnEYG94h
	wsFO1qPVrh2HhZz77bWuDmvjqF2253cI8YcEeq75OlMheVNz/9h0tt53Ulm4cGy8xrNFNyA7qED
	k6+aSrdJt8VeZy8PIOosu+YV+RD2lWD/liIZB3TCHRbO1LhKedpKBo7zWrw1QyBpjYUZDWKqGT0
	Hrt989sf81/2qLu9ENQA==
X-Received: by 2002:a05:622a:14d2:b0:536:8f5a:64a with SMTP id d75a77b69052e-552a604e7b7mr4343631cf.63.1794104383133;
        Sat, 07 Nov 2026 18:19:43 -0800 (PST)
X-Received: by 2002:a05:622a:14d2:b0:536:8f5a:64a with SMTP id d75a77b69052e-552a604e7b7mr4343381cf.63.1794104382729;
        Sat, 07 Nov 2026 18:19:42 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55263e65c37sm7398731cf.11.2026.11.07.18.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:19:42 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/3] fstests: test that RWF_DONTCACHE I/O drops its
 folios
Date: Sat, 07 Nov 2026 21:19:38 -0500
Message-Id: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIADrc72oC/3WNyw6CMBBFf4XM2pq2CAgr/8OwmJZBxig1fRAN4
 d8FXLs8ybnnzhDIMwVoshk8TRzYjSvoQwZ2wPFGgruVQUtdKqkK0bkxWrQDiUghCkOlrE+Iea8
 lrKOXp57fe/Da/jgkcycbt8pmDByi85/9cVKb9zc+KSFFiVgV57yucqwv1j3S0zAeqUvQLsvyB
 QUlS2jBAAAA
X-Change-ID: 20261015-dontcache-test-be6094aa3f20
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794104381; l=1340;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=cUVzEdFJA8DVFpv8wyZ2e8aXWqSn/lSJpUmAg78NDT0=;
 b=i92OW7DNVG7bu7wfx+in3o/xG/FKWWFrwocolmMLSsQl6SxvzRiSyTnklpaLTIKEHiSeEAdMw
 6UUNVBKlMTSC+muh0WcJY5Srmohd2TjPR80l7akK08UlEHgYuoWVEUq
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX+ENDgrmKqyPk
 vIqkJ4jWrJsxJqrE+Ox4ufwZC29tPbVsRHWnTUHcNSsJWgvEqUCpyNrfZD4YuRV0eXgEEpYjGny
 MUZ+8+vZy9YS4oPBAUZEh/wyfJFyvj55gMr79CCYh/Asatjojs/dwSS9Vd4lttsh1f0ZuSSv9Nd
 0gJp7xoSueqluNpnJQMgtPlfwauTfdDQFo5tBPuktLLfkPDMPfcedHqoeJ9r2z3I4MTXLKTDxUD
 YBK4FM5uqRMHgOH9HPeAYpkefErtHe44oTJI9H4BWIUw81LVkwxR8hhyH2/q9DGeahu+3SWQYwH
 y9QNeD3XmeSxO8G0r+QoHObX1gxwQLPUfize10dkn9TlcdY5H1xCP2DGaSGLlExbc83l8aEC22B
 tv8vYThCUEd5//Uxfs1ZFtT1VGxVuT7ioZV8ZlnWeditzqlmCNrrMvPBSVTA9qk9phqZPKwuRRK
 8KUpE0Wr2qE8XKqPOYg==
X-Authority-Analysis: v=2.4 cv=K/a3jCWI c=1 sm=1 tr=0 ts=6aefdc3f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=Ty6xO_GhrNNmo2U9QisA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: -otw3ad7XKNhtCie5a2MZDeYYxScV5o4
X-Proofpoint-GUID: -otw3ad7XKNhtCie5a2MZDeYYxScV5o4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAwOCBTYWx0ZWRfX7QSRWTr2OJ3o
 rFqoUfBKJW+cT8mX1S76x8VYMHMSoIriBZ2KyZdGiJ85uB74SKAHHQpoC8uv/1QELNoyQOr5p7x
 rFSy0v95BfN+1xbNdAsB2Ucuauj/tldDuKYX1aJ+uxM6DQ5rjx+5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 lowpriorityscore=10 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=10 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080008

Add a test for RWF_DONTCACHE, as suggested by Christoph. [1]

generic/810 writes and reads a 1M file with and without RWF_DONTCACHE
and checks with mincore how much of it is still cached after each step.
On ext4 without the fix, the dontcache overwrite leaves the whole file
cached.

The first two patches make _require_xfs_io_command able to probe
"pwrite -U" and "pread -U".

[1] https://lore.kernel.org/linux-ext4/20261012-ext4-dontcache-complete-in-task-v1-1-6ac801557041@columbia.edu/

---
Changes in v2:
- generic/810: fold the writeback wait into report_cached() with an
  optional delay, and give the plain cases a short delay, per Brian
  Foster.
- Link to v1: https://patch.msgid.link/20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu

---
Tal Zussman (3):
      common/rc: probe pread options with a real read
      common/rc: pass -V 1 when probing pwrite and pread -U
      generic/810: check that RWF_DONTCACHE I/O drops its folios

 common/rc             | 14 ++++++++++
 tests/generic/810     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/810.out | 11 ++++++++
 3 files changed, 102 insertions(+)
---
base-commit: d07dca72d2455f4ba8c660ad4c008541ccccb707
change-id: 20261015-dontcache-test-be6094aa3f20

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>


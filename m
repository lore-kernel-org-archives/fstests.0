Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18832392811
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097796; cv=none; b=IHp4EezPnKT4KxLT1FDaR2MqY+XrTFkVtSb9W+d7v4meJNCSWsmPShHQPFITABkNO1/inOFlTDtnLOxxg7UtJ/LYQxM2Tzn4rsqvjbbquXYqzQQ5xWKF+uMNsNDWKKZuwcxeVdy/dpqnSpjocDNIz0JWcQdgO5igNLH/0TvaNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097796; c=relaxed/simple;
	bh=E61kXJGQb67DL5v3Mwx8ZATO0AV/wCVRoPGkb22S4aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTt/fG/zJN77dSEDX+dYeaNT9CrfZTatmvJzg85r4u9RxhR8He9c35aeUhvZu5jOISw8WHKU7LGRIgVT7UWxnxLUEm4/uoqc7i137zxL2QKoDo2DyaKNwEbSnMFs4lXj/1niI+G+XR2yVMrQfSI3qG+wBXd0byCuGeBm7JDA3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hsVBu4Dn; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Qarb8DLg; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hsVBu4Dn";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Qarb8DLg"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FKaI9T2723311
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=8YrZ
	n9RoZwckQ8cIZWMwacpPTzEwwZIsjiX8ntsBR5k=; b=hsVBu4DnOFCwdDUCzVOb
	5sKFxc/wWbMy0ciESscs221bRLuyR3tDCTk3kpI8jOwKGVLzwpeepBYSjmhxSZxk
	9lKAvw1mbGOrk1C0TTsC1ysqAhQteDgt59XKSYMUSC9NlqCRqtqyY/5j47A0jlzE
	ku0HNKxkz1HyW9b7DG88gx0E3UDrYQn2cAochsd1g/dt0aNc3f45+phhCKyUif+Y
	cPYCtHG9ygws0B4giRyO62q2PhZ42vXkDmIHoHxG+5nrh1o2fHTG6LurYpnomoG4
	ra1rRo+VjbZM8T0Vp3l07ukSo8zGmB3Lhv6vwsrzcX2nssyxgHtiRQWXlWVVg/JE
	Xw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hayffmd7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:23 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc0b31ecaso413163285a.1
        for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792097783; x=1792702583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YrZn9RoZwckQ8cIZWMwacpPTzEwwZIsjiX8ntsBR5k=;
        b=Qarb8DLgMCo57BMYOaSyK+MjTtadJqIN6ShG8baczg1wNY0ffHqlEobBNlsHOAUEWk
         kH1Fbg4dYRxcutmMDskqEGg/qOH/m0nSq+JIy2mOX1bkYINn7jWYbcY9KRugJ0WNIb84
         fFJYwig5FRQXdsa2SXCfY9JcYk+Fqvv8MZ753ronOJRvOjBW2JD+Qf1Z1jrPkxjizhKF
         vDBRySqy8wlgGsiPy/DCd2L563hq+Oj+XXgYhsTLvSzlw04cAhVdYOh/r6bjfyy7+k9U
         RQQWmqnqq2Xs1A9+pUTzwg4BnVugKB+VUCpmP9oN9eczJsgoU77cONGkrygZhShdRTNH
         YgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097783; x=1792702583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8YrZn9RoZwckQ8cIZWMwacpPTzEwwZIsjiX8ntsBR5k=;
        b=txHqaQAowaQQz7Xy9k3D+hsmq3oIFwN7kwY+67Colp7HIpoU6In2wqnQ/BFgQuFM+X
         Whvl0qnOn0p3MiZviEgrZW5qEMMvEzPerYUmur0Sb9RVk3etn5a0UERO1OndLL2gvLIY
         NgfUWslJoHwRqo2GXnc7ucFpBSUwmczq63qBjs0qQcQfstGc/5+V0KCz7WEX0Aqr4+Q6
         87EPKnFu57S4nshgnDwipEFg78IEw//2+uFHZhA1YcVjhi4xBtVzItuZ+aK/kf8V6RZb
         FovnXbawEExNCx9v5OdKkLcMqyk3c9yEI7ZB6lrMT3VygKHNFIDnrWYjyCb4PtD24Y7M
         BcIA==
X-Gm-Message-State: AFq9FYIB2FYpvYHrh7pI9owCDCwYf/BqSadL0ll3uNQ6iUHwTG6d7vgT
	USWv/4xjsAhuH8o5ysPLla55BWNoZoTTZ25iDtVfNDeqgcPuN+d8IG8esatKklwIgDez/wRRWEf
	RuPRs2y0WMNdKht50boOytUD9yw3t6rZt0Vp5WW6P34sGX2Nc0R1ve5/O25+wXik=
X-Gm-Gg: AYBFou2ChByI1pWtHbupjBfT/4GbffRg4y/6AeHwfukv+3zpyFWa6cm/0xMaoa8W7G3
	4Uga4rZXNQtv2+EcyhyZh680fXLIDTTkAVaezuDeQhJEoppJxn6QBKajKNRls6PEeU9REhK3dMV
	ZEgr2xcik/htBQYXOStDSjBubI+zr02tOH8+YjrEHeCrnbjBtGvxkOM86DTlV8N3xHHpRxTdttM
	saP4T6ZXGd3JiMMNRSuMB4vkkunXlidOC+4sT4veJi35AsZM7KGXo/YQhsqtQnCxJ7SHjCwvy4S
	4ttiDjCXGPS89Fecsz+mx4BK2e9YBEUwZgiJ5zTFEvUhZmUi1qX0bdMvX8euZ01kCZZFU7KMvpr
	hovO52NVwAuBZC6i4ktqboMYGA2WVxb57Xb+ptzARW8xv
X-Received: by 2002:a05:620a:2a14:b0:93b:d7ed:ff3d with SMTP id af79cd13be357-93ebd2aa64cmr3203870885a.63.1792097783244;
        Thu, 15 Oct 2026 13:56:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:93b:d7ed:ff3d with SMTP id af79cd13be357-93ebd2aa64cmr3203866985a.63.1792097782803;
        Thu, 15 Oct 2026 13:56:22 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1d1bf6sm29062485a.47.2026.10.15.13.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:56:22 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 16:54:03 -0400
Subject: [PATCH 2/3] common/rc: pass -V 1 when probing pwrite and pread -U
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-dontcache-test-v1-2-6aa7583973a9@columbia.edu>
References: <20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu>
In-Reply-To: <20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792097779; l=1331;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=E61kXJGQb67DL5v3Mwx8ZATO0AV/wCVRoPGkb22S4aY=;
 b=wc02po/5ct5ddrg26iR5Ne4D+b/96rF6xvcVKoBp/avVpRWWV0778KRr+NwPR5sxqyNNYL5Za
 yeRoghiVY7kB9bdad6wzXq7tVSBJKRavhiMsKf9qGtHpYbxmiiLPfVy
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfX737t8nQ18Oa1
 Ugw4/Go42Z49QNw2zR2vqu6lQ8EARm9jeBXQswFVBo5l/fHy9SGLfmqfhjJ8+wyo2DAzhwVNXMH
 ZAIh/iscxKhSciikUFnuyfCKqkr5CmLSLLSfGwxadn992foMB04M
X-Authority-Analysis: v=2.4 cv=eJ2GH3p1 c=1 sm=1 tr=0 ts=6ad13df7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=DjKFJ4GTv1yLP1aJ184A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfX+xW9F54rhoK8
 +pi0YiCyla6bqRfvXTESijqHamL559ptYaXVLOSYbNFh6QTOVf4MJp6qFVKtaA+Fk0+Wnhkl3Jo
 VzoxplRH29yHUohh0K8En8EI12WFbC9kktwEf9NK+xcDj4hqE/7rONsSw37SbsoI5jWrvds086R
 De+Yt8a+7WI3aZCb5kD7/m0hDmmmsOcHGD95T3sb0+P6nKYLnEfq9rjDl1yj6qNULPVewOlAGRC
 rq5IkTwYJnI/eRGlwrrHRLC4y29tqP6DBAtbhvMAmEtSxT/0k24+WNF0NLig4IwVB895bgr51Fi
 iyfcgXJv+lX4EZ/v/luMwhlThnzM3r3PjYc58teJpPl9AJZC+zoUTlcUAT8IFHCUS05ts8tJodd
 vBF+V7MRr97Iv8d7xpcvGVQoRHR/f18BdqWpgOHOBraEnsapWBZNA9NXOTB7v+Gi08GbKXwuBRD
 MagAjXwtAzYTWUgMk7w==
X-Proofpoint-ORIG-GUID: eTOa99zRGmZSN_mDWcKkAVBSGx-PBTvL
X-Proofpoint-GUID: eTOa99zRGmZSN_mDWcKkAVBSGx-PBTvL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1011 suspectscore=0 impostorscore=10
 phishscore=0 adultscore=0 bulkscore=10 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150083

xfs_io refuses pwritev2() and preadv2() flags unless -V is given, so
probing -U without it always fails. Pass -V 1 for -U in both the pwrite
and pread cases.

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


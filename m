Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9274C680E
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097793; cv=none; b=eQT8PhCp/3yMjsTK7EA52WER27HQyUMz8TZiVpEj0ysOjoQQMjJhLDEaoRxE9GWeuOUMTfnFhST0jle9qTHiVNga/k1G4Cq7gtguSvMB3MMwriL7N27D8ZVSi+xJj59YXrHkPsxiQwEVc0ZISDyN+AMFz/4GWKJe5fhLJeq8rLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097793; c=relaxed/simple;
	bh=t3ERFHDYX9eivIjhmvdakTJ30No0XhqVZ3vAER4OqH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E8g2ej5QvjzfVw6MxkY9zC8oJ69ye8JSGsizzZ2shc9pxu1iQ09mS7qBbukEBAo1oQGZq5vdEOSigCkRhYGvur7A3TYmKsveGMouPdySTFSD5MNBUyf+vnUFvzkO+Z+jAq65gy5HwXG9gwe6uANGb3y0fk0WQUx3fiNVQnQZhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dFnsRPSj; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WU1zYAvs; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dFnsRPSj";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WU1zYAvs"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FKbM6K2511960
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=aiIoU40pPrOXmxbOialhJTA1St
	nxujJBLhmfDkeENBA=; b=dFnsRPSjLE+yrgWxGIrcdPeMDzhhqlEKuD0TG5Z+ds
	AUuHlN9ZCH6838dfB6JVmoFac/c3nL6TWo7x946MyGxK/eSPYoF0K87Ga1bnuTtv
	MaP/Q7SVnyGawUm3+L536QzGKuIwqMSNrvW5yo2mW5Xk5tWvvcABPNPfuXIXKG5G
	2wFGUl56pOWN4wL75ovfH1NZ7WUnBiOps/frc2gw5PO33JRHdnovk/1DRArkSis4
	C12vVSvHm+b18iRnbY5jGnO4NpFeNg8lonMDEJhEVyqsHXeSkIfc5TiYcpbh/otg
	5dK7HfWVZs1B8eXLKA1Ier0p45BGaQsifZFzIRe5T1DA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4haycavh62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 16:56:22 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf6c528aso995398485a.0
        for <fstests@vger.kernel.org>; Thu, 15 Oct 2026 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792097781; x=1792702581; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aiIoU40pPrOXmxbOialhJTA1StnxujJBLhmfDkeENBA=;
        b=WU1zYAvseWb0lJwwJaAbOvFczstYh0qq1PasrjoqMTJFXkD3fsdhk4n56eAwpASVt1
         2iq+dEH5ID+W8xpge4dqY51rPkxkMxs7TVuDh4KPHLzUcDLAiCm15WwjcSFSBmI7FK2s
         aQfz2nIEQOrZR+ilcDy/HPCaPHks/PRjQDm9gfu/xY5bDGPK/EshpK3d8lv9mzO6O7Z4
         plQWnqhTIu/9he7lsrecA/2DlB7pi1nGHQtZ9CUP6DUDEY6hyjMRrc1fum2ac9aQsy1N
         u3ovzpWVKk4XwH6ElZA3mLoNrYFyxArtmMDtiVnoKqmK+gzDcyLYrfI2v5Y1eZ3G/e8y
         9dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097781; x=1792702581;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aiIoU40pPrOXmxbOialhJTA1StnxujJBLhmfDkeENBA=;
        b=bI8Cnhe5lGvtyAi9+IR7mkwN6LgHmoCGXCC/ZxP0IuWHmpYSIHQD8rlPpE2lhALvkX
         3F7oP0qZG9ur6ky/oL9dZM5b1wxqtDOnl7pm/I9Yje+QPfgW7LasyVKMR2Otp04RM++r
         dTyKWjbqk9iJwS9fuo/E/U/PSRfKd7Wb+5hkG7SfZ5/DzREcgnk4ajznugkxPjQ569nj
         odkccnDa+eMOSiYw8QUT4tJ10caUf4rzwoBqvaC20SN8d/uF1Y3f3m8PtXymoi453a1n
         77Q2tucCvCEsexXE1U/GArwFPb+IIz1DwS/1J1Q7owJxvM0vZWPiuHD5ce+ozL+IHFIv
         s/fQ==
X-Gm-Message-State: AFq9FYKjeb1aOGnSyKJTY/bn05FgJkPWprpUWG1xrRpXoaMiwAK81Wqt
	Jul8BtuIgw/l3LPoIewyaHFWpYcGVFzOlCkbX3u/5Otroi6qANFu12hH82GU05IKUsJGj0kp3Ig
	t3bP5vY8BVqqrygkePV5bDCXTskECSUJjuE7pyeFFfcssfjtB+urq5jlG7t59InM=
X-Gm-Gg: AYBFou2O3qnOMZW35mWVSe8GhtOc6JOLikmhcledt+731XYGQA6uVS33L7jWAF8z+KS
	Krz2FMiXnB+y0mYcgSrORYknkw31PHpRktSqAtsjhD/lt5x1/Mmk2VN6Sj0eitolre2u6E8BUsV
	uodm1+5hRu671Bw+ZIIwth9GPbaYnlPoNtOn4eS8UNSSTaNyJ6rZ1EXM+Ii3RxcXiYH56jlkISc
	KzW2NQ4K5E9BvE/61bHLeFRVF4If7+NgQXR0XOWtvgHvzqEW4pJwxkDLgFyI6newVYFyQjDPEvP
	h9i27Qdt49jfChhjVzsENi8dLxPodEJfAjj20xvmRwT1YrNqBY9bevCttCUQCt5sD5qzsiG+GbF
	RPrwahCH3FskYzjWrMC6bKDN3wmU6bjJAlUL3HHfQZQBw
X-Received: by 2002:a05:620a:6f05:b0:93e:5fff:db02 with SMTP id af79cd13be357-93ebd1dc7camr3348689185a.28.1792097781507;
        Thu, 15 Oct 2026 13:56:21 -0700 (PDT)
X-Received: by 2002:a05:620a:6f05:b0:93e:5fff:db02 with SMTP id af79cd13be357-93ebd1dc7camr3348685085a.28.1792097781051;
        Thu, 15 Oct 2026 13:56:21 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1d1bf6sm29062485a.47.2026.10.15.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:56:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/3] fstests: test that RWF_DONTCACHE I/O drops its folios
Date: Thu, 15 Oct 2026 16:54:01 -0400
Message-Id: <20261015-dontcache-test-v1-0-6aa7583973a9@columbia.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGk90WoC/yXMQQqDMBBG4avIrBtIYhXaq0gXMf7quIiSiSKId
 zfW5bd47yBBZAh9i4MiNhaeQ4Z5FeRHFwYo7rLJalsbbSrVzSF550eoBEmqRa0/b+fK3mrK0RL
 R8/4fNr/HsrYTfLovdJ4XDEUlvnIAAAA=
X-Change-ID: 20261015-dontcache-test-be6094aa3f20
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
        Jan Kara <jack@suse.cz>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792097779; l=1071;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=t3ERFHDYX9eivIjhmvdakTJ30No0XhqVZ3vAER4OqH4=;
 b=aTe1GsCeWgX96xARGRDkdTsAWzQyK+GVufXhmuoXRf5cN0IqkTJK98n/wPoomUQnyrGq6DLDZ
 dlDSw2itHfIDkyO4LhumqIbai2HN5tggFvUmmpyVh+23P3Sui4JC4uN
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfX9dUHLm6E4dHe
 z0gekgFku8fT4v+309q2hSFV4UF95e0C0aJmcdXt0MYghDexaiBxDiZHCX7sAqXnTI2lQsOwyd8
 2o93zmbtxQQ1t52qFByyTDABAE0QZd+sftGkd0wzpL4Drakn1dZmITbabRCO+JNbaFXzIyxdMXo
 /ZVReHz8Z+6caFqeDXCgARRWlwRWZNYidtETWZ2HjvJbzljUev3vugvNJbfJHNIOHyrjMp2vOjF
 YirreZoyShSHAgTJ+Ny6j8WUDh0lWOG3t5Rbxad/Qk8hL7M28neA2fwUzUqidDCyHfanU6xzjC4
 P1o6BZkxP/Vtiygn25bxvmeLg/dITsRHaKZk4NozJk6OYZuWOsH5u6iup9lJnOWtCXbUoUvfufE
 ucISLuyA+oCcTpm5mYBXNjU/Ur82ZtI3sDIKVGp6wleGMFsVMrOnbKKCVmsKZK0BLMdQ+AxVVj4
 3XfikhLe8ZSBguLKHxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MyBTYWx0ZWRfX+tw5tmtbbCz8
 kqzuGBYAK8xUEk+Jv25DngxAWJQFJU0A6NlAoPsntYiMyAKqICSTwQdlRDvOYkwP2g0qheakDAI
 /wea/77woqWutBWlILZx8R9nIucP616iVeO81FvfadE0qio1U2M/
X-Proofpoint-ORIG-GUID: s7-WbFJzQpg-56uZ_Ec1vdMezqhRqAB5
X-Proofpoint-GUID: s7-WbFJzQpg-56uZ_Ec1vdMezqhRqAB5
X-Authority-Analysis: v=2.4 cv=FJiOVOos c=1 sm=1 tr=0 ts=6ad13df6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=Ty6xO_GhrNNmo2U9QisA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=10 priorityscore=1501
 suspectscore=0 bulkscore=10 impostorscore=10 adultscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150083

Add a test for RWF_DONTCACHE, as suggested by Christoph. [1]

generic/810 writes and reads a 1M file with and without RWF_DONTCACHE
and checks with mincore how much of it is still cached after each step.
On ext4 without the fix, the dontcache overwrite leaves the whole file
cached.

The first two patches make _require_xfs_io_command able to probe
"pwrite -U" and "pread -U".

[1] https://lore.kernel.org/linux-ext4/20261012-ext4-dontcache-complete-in-task-v1-1-6ac801557041@columbia.edu/

---
Tal Zussman (3):
      common/rc: probe pread options with a real read
      common/rc: pass -V 1 when probing pwrite and pread -U
      generic/810: check that RWF_DONTCACHE I/O drops its folios

 common/rc             | 14 +++++++++
 tests/generic/810     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/810.out | 11 +++++++
 3 files changed, 107 insertions(+)
---
base-commit: d07dca72d2455f4ba8c660ad4c008541ccccb707
change-id: 20261015-dontcache-test-be6094aa3f20

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>


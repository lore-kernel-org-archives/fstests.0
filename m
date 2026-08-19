Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6172630
	for <fstests@vger.kernel.org>; Wed, 19 Aug 2026 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171525; cv=none; b=nrr07fDH2xpjgfI4MYIFtFeQvn+YpIkK8dvZaE8Ic8e1YwkyWm6YafSROF6hv1z1VYA0UOtbJjCrRyehVn/t6izNuCjRjnfg0iKwgtda+I1mZObF9jAJqHf2oDA7GoAe2E9XniYPD/46dHg4W+1GkArcNVxqHCeUAfpcbomgiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171525; c=relaxed/simple;
	bh=JX8IxcZ2hv/9HdJM2MI+kmWN71yrxjoF0/BjIqQWg+Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BFTD2u9WTIpjAYU1ll1D1Am5AMHAiZR8/gZKZoc4xa4O8bMAVy0VM7B9dlq0Mty7IuOjBUciPTG8btKzO1fGC2kqDtRsFyX+BaXGVHsEpkObEfkBTh0FdRcJbWYZSPUvg2sY2suNKQY7Cx7aaLCyulybMPFzBgiUIki+m3DWxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=uV+qOIn0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4xDhqOy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="uV+qOIn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4xDhqOy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D1A81400169
	for <fstests@vger.kernel.org>; Wed, 19 Aug 2026 16:32:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 16:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1787171522; x=1787257922; bh=JX8IxcZ2hv
	/9HdJM2MI+kmWN71yrxjoF0/BjIqQWg+Q=; b=uV+qOIn0EMV1jD253Nn2/g9jla
	9ijVdFp7Yb6T8mB+2FSmaWAVQPsanspFlXLQBF0cMPlD/Qv8rsEjPumevkirL8+3
	2SMtEcuXjRXjR0TFHRsRvv4kgHyDv1LvuL7wqLtKjpQek/S+AIIH8EFqbybDCoUd
	DHiZNj/tfRNtay+H+D7+4HAW4JHFTKlCMP2edEkSF0ZSUoO7YYE26wgw+dSal302
	/EBKkl9ahtr8dDZzcSmR0p4Yssjb5JrwSbLCIqM6GDyRPzpcYQu+PnRdigYcd91s
	F7DSiWh4J9S8ubEo1WPSdDiMLieOPcbTC7TprhmgSP99xyZCdUtYgO5EiIpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787171522; x=1787257922; bh=JX8IxcZ2hv/9HdJM2MI+kmWN71yrxjoF0/B
	jIqQWg+Q=; b=Y4xDhqOyZVGXMSSCpJ7faMVazzt8mRUXGFyvSQt00dVtr3sra7c
	68XTuZPGNG5a7XbboXCDoOUshM4WogZK5Ku+mAVayJyaR3AbnnbnHttlP3maEIeA
	0D2Np17iWmkgmRsw1UEoQoRiaXAI/h7dTVp6mJ6T/3rzj59M/CgG7ATl4eD75ccr
	8FxU1NkaraZCACNs8nTkFiM4KvKrFmwOR1wvNjK9eDXUqsSBwUYlKmLvy+dayR8G
	dw6YbuoF21vak97lLL4qUngtCal9x6dRi6mzytC0KAqKy6yu50G8pdm3sptHQ8z2
	V0No8dsszHIqHnVs0TJq3YsQDyxHjctyeWA==
X-ME-Sender: <xms:whKGambhG8NjiMh2Yl2OkGeji1SZGrS734o3kv1dt-KV8R1dGzYEow>
    <xme:whKGagWxCAR4w1aAaU__LtHDDlQVARdgUWtMyc-UDeP6BMKCXb9-q6w3fkrqhqxfv
    diPsOT1mswpCrLxRrhYEhF85RXuvixYrxB41QOtCl4BLIOmwVsGF-4>
X-ME-Received: <xmr:whKGamlIfImWKACu5RpFjC5dM5NOCXrS4q42is0i1p3FILUjfPguj2aeCHtSgJnODtV8Yevc3seTt99u7GVk9oeT>
X-ME-Proxy-Cause: dmFkZTFjpO2ujEDuZ0lkhsUyTT8hhs3kF6VUauby1gBmCm8SPBt28Vyle6vHEVUHdbnUBY
    eSqbZx7JTqmD1F9LRjf225OttevjW1PDZaNnAdGXjfSvZabNSKDdxZi3B2E7XgM6CaMh//
    KUh/mKfCrRZ3dFZ66Vm82eWROhgm7DXYtsovmySLFjmo+HHpWjkGsGDRQmUfoVM2qkRDuM
    EYDzC+vaR91pFeE8lYWp4miW8LhZmN9qm14O50B21UJBaesT4xdMUYHUFAZKwUDUArB+D6
    EkV6GG6JIX4Wlgpnip9mKGbcIEK9e5R6jVYk8Rh9aeiMuTk0RGo/hH+pE4FYeKYhD0xGDJ
    m82wpHWhX/wUzhuKmRmDGkkExVLE2AUljzkmXNhdzadWZOexTmOyZQRcL8hAt56YgKSSkb
    Doabkk1RRcO0xVFOTw+VdUthWF405K/2Njy7coZjHAI8yBDf5/6gtCaHQFhgM5u7m5nucx
    hZ72lpsCn0j9j/q/OYSv6CVqDLfBXrI3BVf4U7MYlhkq9ix3Qpn5zGZiulj/cp7wbZa6mo
    w4lHnp9pwleuCGCAOwCe3OlO0TBe7/ysWRpafZxjyWoKMCvuqLEFv3WdBX375oshiATT6I
    jNpC3Z+qPw+cr1ti4vIgr2sy7Ft00y/VD7otFHW4BPP9yhw7atcJPB5C7vIg
X-ME-Proxy: <xmx:whKGatyrOmqE6Al0Aa4dIb1kr1ITjc-M9wFI5WmhwdYVPxebkNAaSw>
    <xmx:whKGahjKV8kGRre7mpFQKZNjIma0E6xDXDcyF_ZrzZeb17XZYIBLfw>
    <xmx:whKGaiWJvXmMYSQEnAmnMd76nzu2iP4Mg6KEKpgf1iCFV9ajojnXPQ>
    <xmx:whKGaj2sBbKoMR8FeXwXHfHvVu6PgiBhOu1Rexz4fCa8RDqBN9Nx_A>
    <xmx:whKGak6q4S-4kq-ggOAtOLp5f4x2XPENtE9gsBUMzbDtEZIsnrt2ztmh>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <fstests@vger.kernel.org>; Wed, 19 Aug 2026 16:32:02 -0400 (EDT)
Message-ID: <a6e9a97f-295b-4bba-aaef-60af17e9c70a@sandeen.net>
Date: Wed, 19 Aug 2026 15:32:01 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] generic/683: _require_chmod
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

generic/683 uses chmod but does not _require_chmod, so filesystems
like exfat fail.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/683 b/tests/generic/683
index 883905da..226d2758 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -24,6 +24,7 @@ _cleanup()
 # Modify as appropriate.
 _require_user
 _require_test
+_require_chmod
 verb=falloc
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536

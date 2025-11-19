Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B8286400
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525408; cv=none; b=KWYrt5fUiUcIgKZ+0FSo514LTdXZlSvJncD0wshtAZPVhZqjsFh+YqId3xNQW/PdWNTNmof1yHvZIN0hfIX7uDs5a87xMql9dVhNYri+WVYx74yefbjs1YHyX/hDW+aLzfKU6Lx/wzUJzYLgpOqg8HMvPkjVW0kb8EclgNFP27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525408; c=relaxed/simple;
	bh=fF53GfDbUj9vcv3GJGIpMmCIeFJl/zpxm8QsU3nBw94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJdOPQHfVImGKpSykWnuiEYpFRYxYUClyR5e3L7QFgKqQTxYRqxSIrPH9GfSKPMGHmpicBFixSzQQvyc2pX3HvzqfBZeI5Q+W1RIraZ5NqfUHzbGdUNp28s7aoYjlTK2Q3s0Pb6CnC+XQUOfRNQZAkmBX1DqB/7/nVeSfK0QRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmE6xzat; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmE6xzat"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ba92341f83so2641677b3a.0
        for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 20:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763525405; x=1764130205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8UCZhwwf9t3MtvkWfQO0Q94wHMfsVWFQb5oYTizu+bE=;
        b=WmE6xzatBsyuY3cJ4g2CPWgnUB1K3CmacrkcXWbXLYG+tUwzXLBoUbb5TU0+ZYhKNq
         4MWKK4xeBinCx0Hsl8xMbe6MGny/qFoYLt8JxW4/tq4sJSKb5CEK0J5NoFCZdapA8NU2
         kzmZe950+QoGTM1rjOveSmtPV37ASU9SS4yWpMe+4vvX29tucw5mvup6a8BfFxpWl4WH
         58qooKqDzWi00uaq4S2+uS5aMJSuU9tKWLOZ528HyFzEWe/XpSjxMVwt4Iq327P+K42u
         ZKjUGUFrz8STBCVloD1Pk4MOQW6Ms2JMAkDBhg6ALxPrklY/g9+1WqIgFnvzWyEN+hvO
         4Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763525405; x=1764130205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UCZhwwf9t3MtvkWfQO0Q94wHMfsVWFQb5oYTizu+bE=;
        b=BEvQj2ADDD9a2IWjfpmkcioJgW4URxbAyOmAkMwSRo59QMpt4ejuolX4pMKEGtUHP8
         eqrQ/BbFpeb6EnkUiCaSxPXNZVPseKphXYnXZCI4vBVmrGU5/F6jArcyVnBL03w79Kbr
         M3/bR5NjoulR6xYhWq/7TRwk2UCXqhItQ7Mcv7cIfIqsgfMKv3clUYWn+IeNL6erMi6D
         kw+Yh8sNihLtKL9tHOfSJO4TIzfVqQCJ62oUZD1u6o3Xv7kMFCirJIFtEc/Ul1x+zWQU
         x0u7CvIby+ex1V5J+vHeVTeMoIsY2UNtUZREJKFlif63SKFAve2f47a1/zUkZMTRhlPX
         +oyg==
X-Forwarded-Encrypted: i=1; AJvYcCXiB+hIWZwvqWb39avpsz1Q25CZ5SPIvE7122pVN74blwK8HjOjqxKxaxzBg4JCVHPEaRN0lghG@vger.kernel.org
X-Gm-Message-State: AOJu0YyUywoa5NMdUqgEKcMjxlD27C3BJaAu0yc/vMiR6OVH/9RTgsyF
	zVQmBJBeh/IbBtURawCqvqeQxqJtkGVsk0JKwm5xZ/w6n1n/e8P4GBMh
X-Gm-Gg: ASbGncueIXYZDc7MSOwYG+/yVX0SHs3BzrUq49rK2u/GsSX+iy5x45aNLQeJWlT6Txz
	YYuXVayP4CLFppZ6KzltgVNOmn0zxsInnDi4l1TPtlSjiDEALonR1WiWk7bAmbKWKzd2VNUS6bA
	FXurBXoFOGQuG0qnMXd0BPcNFo7qmYDQ7tinGisFw6fzsSgDI9QX90kmVmmX8tKzVN0FFR/jO5w
	KYOpVQDdkV6KK0ZxTTvXaup6p6Ej83/9AeRnNlgB3a//pca8h85KclDOtVoCk+LbOwMWaTuvzTY
	ipzK0yypTdZhl0/as4+DTtffQAgh3mydDAAjMi+HNtEm24/bfV32SR7A0upoHrbxfH+GBBVBTIX
	y2554QAySJfUdZcuNbsrqw5U8UteqfMBt+Xu/Gs/Dfx2iHng2PDXHdzBVAZ09xXpWMJeBz/oE+e
	a2j38g+NU/+Cl4G8bd3N809x3QG0Ocacuow1Go6VTF3IK/jc6HipdEyZV4l8nl8c4ceOrhD99C0
	Qo=
X-Google-Smtp-Source: AGHT+IGrKtdbjhH8spRFYFh41PWSFa1moAkQ39DvDP0LAr5d2ystUs246cMJKdvAqgR+t+Qk0PBdKw==
X-Received: by 2002:a05:6a21:6d96:b0:34e:7bef:e820 with SMTP id adf61e73a8af0-35ba229d434mr22889590637.41.1763525404682;
        Tue, 18 Nov 2025 20:10:04 -0800 (PST)
Received: from [192.168.1.184] (softbank126125156093.bbtec.net. [126.125.156.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db21e76sm16871112a12.7.2025.11.18.20.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 20:10:04 -0800 (PST)
Message-ID: <15aa65ce-2d29-44d7-8316-7e90535b738d@gmail.com>
Date: Wed, 19 Nov 2025 13:10:02 +0900
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: Add lustre support
To: "Day, Timothy" <timday@amazon.com>, Christoph Hellwig <hch@infradead.org>
Cc: "zlang@kernel.org" <zlang@kernel.org>, "zlang@redhat.com"
 <zlang@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "sihara@ddn.com" <sihara@ddn.com>
References: <20251118073011.362595-1-iceyangxiao@gmail.com>
 <aRxrgesZ948FOWTt@infradead.org>
 <E35FD5CE-23C0-4A3D-B563-93E19F929291@amazon.com>
Content-Language: en-US
From: Xiao Yang <iceyangxiao@gmail.com>
In-Reply-To: <E35FD5CE-23C0-4A3D-B563-93E19F929291@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/19/2025 12:23 AM, Day, Timothy wrote:
> For better or worse, xfstests does support some out-of-tree
> filesystems like gluster and bcachefs (both listed in the support
> matrix in the README, which also suggests that " Firstly,
> there's not hard restriction about which filesystem can use fstests.
> Any filesystem can give fstests a try"). Lustre support wouldn't
> seem that out of place, even if it takes a while for Lustre to
> make its way in-tree.
> 
> Tim Day

Agreed. According to the README, I think xfstests can also support lustre.
We can improve lustre through xfstests and give various feedback to xfstests.

Best Regards,
Xiao Yang

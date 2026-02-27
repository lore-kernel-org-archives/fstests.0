Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB0374162
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2026 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234881; cv=none; b=nIW4PkOFGkmZ8axl1YIc2bCKDZCrtgEzJPPHotCjdtao+WM2NZKP/7c6P68dAH1ZQtmaZ7LuFRctUjKkCrlkyyzdzzD9rUtFsllUdM7DHjpp6C6nnlpZ139OVmqVJFX6Dfb1nB+JqtBsktMp9h6d7XiqLT03e0S580wAbcFqDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234881; c=relaxed/simple;
	bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuO5HEBDKhLZh3bZXNGn5bp+VGonfCF2fR2+jKGzvQRumRC4Uaf5db59B0TlYa49GwrDYwj3s7YOuaqtRTjMCPgYXFBZNFtyiiHxS03hDAhoNopKF/cK1N9FjkLN6vL7/UWHxn5dM8ZNBj6qbbK0QZ1UkaoQ2S+nVW/fs+MSbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnn64kn8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnn64kn8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-356337f058aso1372344a91.2
        for <fstests@vger.kernel.org>; Fri, 27 Feb 2026 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234880; x=1772839680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
        b=Cnn64kn8qtTxu+QLGBBBIJKEZljbDN39CK5X50p9+tsK3iYoEgMxQ+2kv79ZIQpJIT
         cuvowZaxkOOKAPF7omfNqaIL78pCo9bcrZLNfat1x+rCl+2nCxKnQ9jUK93zPguxYJVc
         FnqoXP6sRNsysdM1HNbIY9QMAF3eiXwB55xhCcowWvciBocrYhAL/EmsK31IvIayM9r2
         NqhvDnYMzoJ0oMXersJNNd30jUqwp01VMOfhnggfY3jiyp32lbR5jk+ObF5S4dGdBRhD
         G5RLEI4GGFVQBaiVVd4deHxQq4F25fAERbchG+DLghq78g02GWOpvSZoECsjebNQMO/J
         3Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234880; x=1772839680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6a9/T/8KUsonOtUFp4gCTDN5STRZkJWj7O158p6guA=;
        b=SUER8vtiXoZ/XusyLD5wmppJJTrlmD5SSfCNZ4fhMRJEL6F/NWVWh3EJQn+EVQG6HI
         c0ZmCfBwEsbiIMa7tCDp9L3bXbIe8iVyCh8Q9s9sLaN/zXbi8rFVR+NIswoCPGU44sde
         Z4IgRDVOe2ZqQvsJWvQscLFtvpNNg1KmjVZhIGL3H+KDkT0OjBTEsijpzM+CTIDZDLUY
         hWSEpc5xpbwhJQBl7554WlYDGq+M04vpjQQP4E8t2a7tNi3lnxZGgvKpJgu04/FALipp
         fpBpn5IfnAv5mt/lFL3sw3POfS8jxrsql2AZ5aCEVYM8NjmX7C52Cxv52b4AfbtbIV00
         N2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5q0LUXMXIz9mm8JpqNLLzTSQxZ3HZi90YY++/Zef77oRpXggZk8cAPCwKJtGQphcJUf7bCI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwRofrE0sec86NwrddLVih/hluprqoh9x/VXiTSCzI6aWP1bi5D
	+HYH0CEoemGqy57Hot3yphKCEpG//JCYagIdAKlzsNSQZi2/v8TvHGaxR4athA==
X-Gm-Gg: ATEYQzw2Dosjx+U+AiBmsoIgLZWwKpksRWQkJn6TAFQf0soq7USxKkawdAXqiEEYLc7
	UJs/65m/EWC0sH+hsbRw2FlNk0ht0DpsQXB6Wa6h7D9AOXFF0ZH/UUixY0RcGF3esBgxNOPQwwj
	OU0kcJWYyT7mzwKqXiRsUCozXZUCIcqy09XX3p9oH4N5uCG/V9Xs5LCNJ0SUD3Jp7NRecS1N1EM
	eOktxDMOx2Ic051dhVxoDfzpAYgFA6p8uPBuJfCPBQWQe10SyPnYDaccVBUsNTx8Ya1cXEseNJk
	9DHxuoU27rTU3WRociEeZGZgTCZcWmSMAhK10LjnVnr7MUlWFhMobmwcZjy0WFevmfvQVD8Tx0j
	dRzM/vR+2rI8M9A4H0orq47tgAh7NVBsN6wx/InZ8hOa4DMCkrstsvuYWyrp1d5rP6C+XIC08Kc
	rjTjAh0RTPBVJxe5wxz/WtYJcGuWs=
X-Received: by 2002:a17:90b:524b:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-35965cf519bmr3283898a91.32.1772234879963;
        Fri, 27 Feb 2026 15:27:59 -0800 (PST)
Received: from [192.168.50.89] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8016f9sm5453294a12.17.2026.02.27.15.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 15:27:59 -0800 (PST)
Message-ID: <1843362c-1b5c-4b65-a7b9-1f489e6844a2@gmail.com>
Date: Sat, 28 Feb 2026 07:27:56 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test setting the same received UUID to a lot of
 subvolumes
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <6f697483d00fc7a001f2ce752a545d525cf2929c.1772151075.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <6f697483d00fc7a001f2ce752a545d525cf2929c.1772151075.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Looks good to me.

Reviewed-by: Anand Jain <asj@kernel.org>

Anand

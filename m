Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F33E0C48
	for <fstests@vger.kernel.org>; Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697227; cv=none; b=lXVqu5xgJI89vrNq56ZdtsgU4O967ecCNKcvtVJGFMhp8OCbfB1sZQ28coMRLhveNZTS501NnyRYDKggb6nzVGfHun1RwKeovH5S4gnJnNED7y0m03T7e5eHPlnLZKdCve3lRLxnnESi0fTXvtHyvbL0nXq/dJg6pyaY2i1Sr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697227; c=relaxed/simple;
	bh=e8rEW29dCniH2gKK6PkMgFes4ymdMVTdoX5svgA4o5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N651uErScvXysrumKi4JuquDCyDMYFVhbRRtbueWASCTGjUlj8sKvfggwsiQxNMlXrx4TtQdEHp0nv0YOr6anCG1z0/olKTv8/glnPUlqSI0XdI7DbEXOWvh1BG2bFqp0IfsqSCti4uKNLCnptlLZ/Xtt45tsluD0Yw5tZZNPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9X0o17Z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9X0o17Z"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3235444a12.3
        for <fstests@vger.kernel.org>; Mon, 25 May 2026 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779697225; x=1780302025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=;
        b=A9X0o17Zr89QqXeFZ+ZRnPmMd2mdJwS5yCF7yiSkMvG81FroLZQXuGSjBdM7ah4Q7+
         HH50kzRRnTXkVj9b1mBXISGxmwNJxtnCaaA8kovV/oXbiqjKV4S0alRvDF6fbmS7BEO4
         xJPUmMkg8cmyAq+BlQYrnN9ZzD9yjvNyF4XoI7LsxnJmS1RtXYxwUBeqHJszbj007Wmz
         AWZ6t8MXHhDOKNLct4zlD0+wxXz5z1xle2G7pTGZVk0nNBR1cxCrMILtddJuf5CuwSUQ
         38C34iH2ziiDnC5uldEajKL/TJBfV3RlvP7MkmSGy+jSTzJqjDmS8AH339dS6DnKm8GE
         KWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779697225; x=1780302025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=;
        b=TzUqEzKJRmYxWvfuRh/aQNevotLj6NjHt2XRDWpxlZog1bADroKJ0mwYYXPOvUt6ED
         3cwfLqKXuvg5qNji/vKENXjvSGAciqTHuqfcYCU8UNBEGaoz5jGuIWtMX57sm7921Qd7
         huAwYfVpvQw1oN/VnURS+Qyhn6AsBtbNsjv+jEhrNS3CtSZ8HMiMGuF5WZezch4oUi+2
         9Riy5pufQ+RAEn+a2oGiaIomwN6+1d75eIFEXpi+WE00aFZToB0joWzDj3OLp0n2y2RT
         1luvm5tCUhFDGuyX290OwTBrvECLSUEI4fXPnDh8UCHSJTZ4EmewsalK6+M2bmIvKTv/
         Oe6w==
X-Gm-Message-State: AOJu0YxISH5GUceT3Jpei+eNheE1qBbQZVEYWLhPBTPQ8pMXo1NT4vly
	0B++jkn5Squ+9RndrKiZe8XqyK2+Eu1Uo4pkNEFtED3IN+6GG5ONMwJb
X-Gm-Gg: Acq92OHZ+f/JKThkdZKFxM11DXxyx+VCjHtXzKASPryjpCKAB8SqwyOeQGxqU9K0+Wu
	3NbiPnwWcW9JZVAZOLWzrtbdCD8orwNY+uILiFzM3TwvUr0r4dOjvC5v/R/PTBhqk+Jm7EScAZY
	eoFZurVgPcOTB0QsurmY7Y25lfT1lVHE5BfV1CdJyoI03i58OO/aVe1FAPqI/qCRLMlWKeNxlXa
	FU8opIWiY2c6mX3ZJPd75JbpaU62+t56luGtDm6CzpWEarfG3BWASZBs+5kx/rTpmiCYVYaOMC5
	3/1Ko+6tYFvqG/XNG/j/aNgq4I9bfBc56szHNP2nuKm8fZno3zkPqepjMhdpRfu3vM8CM3Jy2TS
	OwYqenC+rIVxfvtMRdaWnYzZvDDHKT6t1wNLsdEswwSFLI1WopuMw0v+r0NFUOL/I4eVNokUqhp
	LBBbVboqGqvKTQTS8OKeinKKLp9iY=
X-Received: by 2002:a05:6a20:3c8e:b0:3aa:55eb:a5fb with SMTP id adf61e73a8af0-3b328d15f18mr14912245637.23.1779697225436;
        Mon, 25 May 2026 01:20:25 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852056d767sm7212551a12.25.2026.05.25.01.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 01:20:25 -0700 (PDT)
Message-ID: <0f774a12-7355-45de-bf95-4c98193d4727@gmail.com>
Date: Mon, 25 May 2026 16:20:21 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] fstests: verify fanotify isolation on cloned
 filesystems
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, amir73il@gmail.com, zlang@redhat.com
References: <cover.1779367627.git.asj@kernel.org>
 <bfc0c92a33bf5a129dad4c3e4c76973e7a6cec74.1779367627.git.asj@kernel.org>
 <ahP2OOXmwsM87j9D@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <ahP2OOXmwsM87j9D@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/5/26 15:11, Christoph Hellwig wrote:
>> +export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
> 
> Same comment about adding new common bits outside of test cases applies,

Got it.

> but why use both inotify and fsnotify?
> 

The SYSCALL and stuffs until fsnotify_..() are different,
so I decided to keep them both.

>> +[[ "$fsid1" == "$fsid2" ]] && \
>> +	_notrun "Require clone filesystem with unique f_fsid"
> 
> Please add a comment why this happens.  I also have to say I find
> the if syntax easier to follow then && with a line continuation.

Got it. If statements are better for readability.
Also, I'll add comments.

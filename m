Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257574A1D
	for <fstests@vger.kernel.org>; Mon, 26 May 2025 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236274; cv=none; b=TxbrBkZPn4NDj+B3k2Ykg2F5fGewgGvRKm8yMO+N2JtkGBS9zHowsVTrVk5ibOLMa1CaZO87leCwHOVwACjXOpy/Ew1wi1qu78mFAvuz9Myv4RNo07/ZFhL/Olf8Et+nJ1UF79gKhBBGIaI+5v3XkjTon4TDZF5VnU8zjtKN0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236274; c=relaxed/simple;
	bh=TpV50D2wJh7mtiWER2HplFwUnhJHx7+TwXAs/5qg0Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqMePTgm79YsJpyxvtGeD3Y9xgXwPQiiDINTMBQTN/NQ/qjLAj6fL6lTidITHPcypX7aRhtDPBEgeRRZ/aH+Nv8lzNLV0974Ix2hU2+Pk6wQKufPx9OCj8ak4CYQaQbH9CpNEZviMDiy1B5k5gKd0UpEJNSu1vx0m0VI8HUWdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp3AFVRG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp3AFVRG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23278ce78efso9896325ad.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 22:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748236272; x=1748841072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/QKsIXf6U2vBi/PXJVhug4Bp3BSqVR/a8qI7P8v5/w=;
        b=kp3AFVRG8ypF0dpHBq1yX5wFTBjygRhFTED1Ziqk1AWVvLYPnSSQltq5ORuM5cgUS+
         EvyilyCEsRMvSfeFyPpM7XOmLRwzkngHL9zB3TgIAyiYYeDFI4TFk5c8aGJ8lRK/QUkr
         ARQYj0F7C9wNhQDewSSZb/y0SKERbMDkDSRsTVAcGuiIIfvuMfgpQTATc2zg1bDUJuVp
         Op1Z8zgZvPB1ofjs0jLXfv4kYDubTCCvm59BL4WfCCxuUNIak62UMoCRjl/6KZeeBH3F
         XN++COhpSG3pW+hcBo6POcPpvacZ6XtPYpM0plU8MrM07rmEYmUgbQDD95O2iMWtGxf2
         t9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748236272; x=1748841072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/QKsIXf6U2vBi/PXJVhug4Bp3BSqVR/a8qI7P8v5/w=;
        b=vDpnNEfEzAPN6LzcE63pdAuGBhAk1ke6Ln+89UF6VP1oUtxe4nogrC4C3hEWfKnwF/
         QHVGuoOPGLiOXB8d1+Cxjd1YFxA4WTO3Qr7c14N2dXb5BporqZjLs3Zt+ylcSJPLIjmo
         UpBBIhG7/iOckE01pCA4ddmbuzykBpZf7EUNICupQYz25bgc9woxUpmBO0gYJZ6RagGy
         m/XAKi99HXxGLmTeZRkWDvJMkGk3brJsTKE/VhnyLrG7+zGRobqJxPn8gDYz6WwToZUn
         NqYeIcjx7/UJzQbx8kSnJdycnY9rsBnzTRqoXi+VlDosbJoUDl+/yGgSHiwfcDPjnpTf
         U49g==
X-Gm-Message-State: AOJu0Yx4JnIybc3daSa4EG/c6qUs7LvrJrT4b+pi9S30O4WK6XElHB8N
	VXIJb2UNJJiUsUs05Jcl7IIYkdtgcT+KD/pFp01JMIyHVfrE+8z8mMgz
X-Gm-Gg: ASbGncvahJsFJYCnVO+vnZOqyqzMY3iwOP3OA3uQBXiTT0AI2zlkJEPYh0zZJuxWonm
	tT4+bUY2S8hVttE9wrG34LvKq/Cj/gzomIjnVvFbltDZU4VQw3kPN98PRZMdTYs0AaY3SJcUWsV
	clNj/DKEVzaFa7EHoeh/NSFdRVwSlRjvzVra1bPdd7+m4YPGY4wqN3L8g6xNVf1l4YuuU0+6SDw
	EYNlilDhkcNp0EQ3Xzf5FHkRFCPZHe+QXny+IAvuB2tVEiftuI8FPxkd3++fbOh3C+ft1LJMfDL
	I03p94dyK7UmiEpr+m0jALCu/czFYiawBkrcpOFk6jsOAFAmgXzrw6X+eX80oQ==
X-Google-Smtp-Source: AGHT+IGs83VjzhVgufQKdpt8JUX16D2ZKVLXifEjBYAQB74w5NI+5rJSjAzanDetBOQ2Tu/HykIImg==
X-Received: by 2002:a17:903:2ce:b0:224:2207:5130 with SMTP id d9443c01a7336-23414fdb06amr121475685ad.45.1748236272280;
        Sun, 25 May 2025 22:11:12 -0700 (PDT)
Received: from [192.168.0.120] ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234685b2f43sm7832335ad.198.2025.05.25.22.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 22:11:11 -0700 (PDT)
Message-ID: <dd00260b-8662-4b0e-9543-2ac07792b4bc@gmail.com>
Date: Mon, 26 May 2025 10:41:08 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/28] open-by-handle.c: use syncfs() rather than sync()
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-24-david@fromorbit.com>
 <15e09df3ecf75b4b7da58fd2e00d5f72aab2d493.camel@gmail.com>
 <aC07TfBnIPnDNrQN@dread.disaster.area>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <aC07TfBnIPnDNrQN@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/21/25 08:02, Dave Chinner wrote:
> On Wed, Apr 30, 2025 at 02:32:33PM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
>>> From: Dave Chinner <dchinner@redhat.com>
>>>
>>> generic/467 runs open_by_handle at least 15 times. Each
>>> execution runs sync() at least once, sometimes three times.
>>>
>>> When running check-parallel, sync() can take a -long- time to
>>> run as there can be dozens of filesystems that need to be synced,
>>> not to mention sync getting hung up behind all the mount and
>>> unmounts that are also being run. This results in:
>>>
>>> Ten slowest tests - runtime in seconds:
>>> generic/467 442
>>> .....
>>>
>>> This test running for a really long time.
>>>
>>> Convert the sync() calls to syncfs() so that they only try to sync
>>> the filesystem under test and not the entire system. This avoids
>>> interactions and delays with other tests and mount/unmount
>>> operations, hence allowing both the test and the overall
>>> check-parallel operation to run faster:
>>>
>>> generic/467        6s
>>>
>>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>>> ---
>>>   src/open_by_handle.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
>>> index a99cce4b3..816bb5d12 100644
>>> --- a/src/open_by_handle.c
>>> +++ b/src/open_by_handle.c
>>> @@ -430,7 +430,7 @@ int main(int argc, char **argv)
>>>   	}
>>>   
>>>   	/* sync to get the new inodes to hit the disk */
>>> -	sync();
>>> +	syncfs(mount_fd);
>>>   
>>>   	/*
>>>   	 * encode the file handles or read them from file (-i) and
>>> maybe store
>>> @@ -563,10 +563,10 @@ int main(int argc, char **argv)
>>>   	}
>>>   
>>>   	/* sync to get log forced for unlink transactions to hit the
>>> disk */
>>> -	sync();
>>> +	syncfs(mount_fd);
>>>   
>>>   	/* sync once more FTW */
>>> -	sync();
>>> +	syncfs(mount_fd);
>> I don't see mount_fd being closed at the end. Maybe all the file
>> descriptors are closed after the program finishes execution?
> Yes, they are closed on exit. Again, simple test code that isn't
> running out of open files, so there's not a lot of reason for this
> patch series to care about such existing issues in the code right
> now.

Yeah, makes sense.

--NR

>
> -Dave.

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


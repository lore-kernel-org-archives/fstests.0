Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B5217F2E
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841725; cv=none; b=ITzXUH6CTeszEzFWCl4f5fBw1lKcjZaExA/oJSLnnxRU9a+QvTV3FDVuWccgF9lap1GM64a4cYRcAVuMkVZP9KGkhym/HU7ML0S2dGld0ib7ZWltJ/gh02yvK9K8v09QFNk0lDwV83Y4ZGFCHnIMMYUcIfOQozyQ9MKZ5HrMP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841725; c=relaxed/simple;
	bh=hSThXL9/o8orNTOUmeOEbhzvn1R/valrG/O+3Z4zdZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exde90w5CtB24/E3bi7/k7Cy6aBYdp0jWOs3XiK22TYayY4cQ6FLWExD0cEnUkxVlJMAuW4zbIKAmcJ1eHPl6kLXZ2Ap666ZqVnin3Uv1q/YE3NZFGjnLWHkqLEjpCq1FCBcMznKhA0Ffj07E5victxe5HETnfFbAxS2LECYoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OROFJs2j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLSCg7O6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OROFJs2j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLSCg7O6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768841723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW0/pgsrK4DPsXD49ZCnqBR/wZtXnNQHuMugKiZbtIc=;
	b=OROFJs2jxcXlI9s/mmJlN9v9/YUTxoGI9doKotlu1hxRd1vJgoi4KLxHgBmg5lg4naZ1Rw
	5ze/DWdAgzLRIH8eeTb/hRQ7oD+NTigb85tFtYY7mrUZO1qRhCo2BhYHKK0f4KcogU/A4n
	gGXL5Di9jo5U5ZGc1XvISHsY2Q9SsiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-0aOrK0biMNyZrcEzjkHJeg-1; Mon, 19 Jan 2026 11:55:22 -0500
X-MC-Unique: 0aOrK0biMNyZrcEzjkHJeg-1
X-Mimecast-MFC-AGG-ID: 0aOrK0biMNyZrcEzjkHJeg_1768841721
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-434302283dcso3481409f8f.0
        for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768841721; x=1769446521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW0/pgsrK4DPsXD49ZCnqBR/wZtXnNQHuMugKiZbtIc=;
        b=OLSCg7O6c2T5+boRjldgGvg6HNcS43pKNLOJzBCziGEgUSokwWY20rA1YMyVolxot6
         6E8e01MLWPPyTWSMpK+UAxEFWawUw1ypGZmznHm/cFRVvCHv+88AhS/BkNCmZRqmtCJN
         hdeuK/0IdJTlxAKdK02+gvufKJ80+CHhMgBBs2lHq5ta9+Cxsdwc2I5B/HLFtZPb15Pt
         2QWBkSDcp94f5uaIB/my0dJMdKdYUF2Up2ZNxdVfXhCJaEVUGqG7+q9z8l6X5h94POKr
         hRHeGk4xMHVL8VNCkAHgK4ja1fB9LWDgyUqRvx/R9FQgOnDVJH5soxjVFGuw6iuuNjXq
         Fv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841721; x=1769446521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW0/pgsrK4DPsXD49ZCnqBR/wZtXnNQHuMugKiZbtIc=;
        b=DZAYA5KG0Fxy0E4mZCcDh69Ji7crgL1ddbQYFqIGPD2glu25h7HJ0J+kp3ZlmgODUD
         FfRLUw+WEZYrQjE/zW8IhhGoSrW/mKAKBIxHGM5KLTSSBbtBFF8fI0JJjs5GfCAY7kWE
         jDh90d0BXpOVvVj98XhwISnT30HZHdTMlS+q+yKNuz9TJfZNLO98EXd8o5He8zs/VFap
         OL3eeINigmgd6+xG53r+mGt6KWYDpDUxCMIy0cPh1rUkPAmECJXApoisr6YxBt3XgXvs
         HackxM5SNIGQ0fVhhQQRbXCFIy/mDl/MyV+41msyxE/OZXZsKvq8+lLIvttmUBiqY357
         65Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUxqCaWcQJ7LoZCVKlsjt2l0sXJuz4nZihzYuWuhA1IpHcrHPOXL7ahwZxJcMTZLiaXUhTWJzVi@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSXJwNKWY3jdw1YvgCkQxh7TJLBbYozROba0Ret1btKK+Cuk7
	3tLk3rB5NtNA+v9giKIUeXiGjMTuBt1NAek0rlWuRX+ebrR4k/UOdclt1hjISZ4EHnLfXu/7Dpp
	MbCYaPrsTX3Fno5k2IDWAsg47myiF0evrC8p4Ex+WPbvJAsplADo2mmBBPA==
X-Gm-Gg: AZuq6aKQvv7sDVoNccDmvecJ+F+4TBw3dfj5ScUAwNxn2rtfMwuYg9gcxp1IoCVzbM5
	x4uy5Bi2r8pe0T88UD1R5hP4Fm/nL8U3zBBuQFMoPPy6SoseKDSj1hrD6wHH5IGgDJX0Ff41IAi
	0B8xKxoP1y/O/pwpa7D+XaUJuc8NDxjawjdzUwXz7VXORDQcvcRaepy/rI12Y6TJTj1XYMyyc5O
	tWZvgJ+F4nLqQQ3IUR6UzYfe+BCJpSvutDgUnhhXNApmQX5thl0Kv41QxI6N9hEYtQKVxk//yK7
	heLGPl3lcssA7N72GFH+7KM7x9RVS+11/soMePynf85uYe8bpYrFGiPa7sMs/F3FyzaMzHQ2pyA
	=
X-Received: by 2002:a05:6000:26d2:b0:42b:4185:e58a with SMTP id ffacd0b85a97d-43569980c3bmr13583790f8f.14.1768841720802;
        Mon, 19 Jan 2026 08:55:20 -0800 (PST)
X-Received: by 2002:a05:6000:26d2:b0:42b:4185:e58a with SMTP id ffacd0b85a97d-43569980c3bmr13583762f8f.14.1768841720387;
        Mon, 19 Jan 2026 08:55:20 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm23750935f8f.19.2026.01.19.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:55:20 -0800 (PST)
Date: Mon, 19 Jan 2026 17:55:19 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, 
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org
Subject: Re: [PATCH v2 0/2] Add traces and file attributes for fs-verity
Message-ID: <wiuypaq453nlrsbmg7fqwi6x4hjdg4dmbz5i4mwuwhgwgzdj37@a2mbukyfpybj>
References: <20260119163222.2937003-2-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119163222.2937003-2-aalbersh@kernel.org>

ops, wrong email again, will resend

-- 
- Andrey


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA516EEB3
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616824; cv=none; b=KP6TbhN1Pbzem/61w+FN/gNzMgeJOmoCwHb6Hu2c0vl+lwbeLPBGDYwnOjzWMSrYeBxj6wDD3vjr44Kbv47Ogh69Ffa1MnhxA7FrciIvw2z59BKMxaudsvFPU8YCn4ham/jVZa89S8vd0jcPlY1JfC0oE8F4L5PoK9vFAT05BfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616824; c=relaxed/simple;
	bh=emG39WxeQGo1PZ49MTVMNRCAKXG2ggqKdZwjT/7ynuk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BEHD+dANa+2mbkkZQnrAQsFC4lGPvxdfrpLrcYSl7g/OWxWysGxTu+a7bfBS5EmNd5T/nA17Dhba4zHnjqQA/un96eIp1zuHCLTjKeSEL+U6KiKLXbJvlkM5FJWtC+sEug2e4o4NkNcdkNxewbFQzY6neGfp17ElV5OXhvH6iZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Of2zkvJ3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=svqUWZce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of2zkvJ3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="svqUWZce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787616821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mn4SmoZAJKnXKheoM4LWMNnXsBHRUTANUAu2DtgCDkU=;
	b=Of2zkvJ3wLXpcZKaeRcv/ZKp7Ih1ea8HKobN20VTnSsC3QgHWYr6+PGWtdElQJPmxAHNmW
	GZRt0X25AUjBJAjqpofDRM40h7wjckJ0EvX6HDi5yO/6aOc8yM4tZylU4WlZSW4NAFgSrT
	EQLVQGSlVdlBbmsahCHa9O+rH1wEHvs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-7eMHOvtpOWasIp6lG0wPJQ-1; Mon, 24 Aug 2026 20:13:40 -0400
X-MC-Unique: 7eMHOvtpOWasIp6lG0wPJQ-1
X-Mimecast-MFC-AGG-ID: 7eMHOvtpOWasIp6lG0wPJQ_1787616820
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ec5495f105so5196925a34.3
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787616819; x=1788221619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mn4SmoZAJKnXKheoM4LWMNnXsBHRUTANUAu2DtgCDkU=;
        b=svqUWZceO69oe5ax0gy26A3alNUakOdlWAjVQUt9yBFRTqRS9Ifhvaee5I4i/pGil6
         GWVVmkwFtqfhgwbE24+dXcYgJKGKXzLvsyk2wHGMwxyy6+WY1yVhM8ntgECnxQ6ELUEM
         hoj6gep98nDpmQoUWqnIsrni5MF8hL5np67USNOn8+lwaP4MoARlAoOsj6fvm70MA8FJ
         +/bGf2ZjodorLlg99bsskpyitRNjuNuMLfRyzi2SLbeWgia6Hxday/nzV8LfsY/XHhDH
         UZ3f/rmUPLc2esU/Rmlh3P8ZycV4BSI4NlZtykTJdjDPGcZYebQVTk20iNw2LQPfQ7Pc
         JQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616819; x=1788221619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mn4SmoZAJKnXKheoM4LWMNnXsBHRUTANUAu2DtgCDkU=;
        b=JwL8rKU93751ykBw+zDvWUsnTuGF/wXSSjCa+G3ov4sNvEjD4fRyn80JO9LDnjB8ox
         EbX7wvd3Ux/9WK9IKEI/8fIHFI5bLARTO6mXqLZBhZiu87+6kdD7/4MYIDTAEdN93+ou
         X3RKDt/nc/zIje4nGmXSN+bx2fEv8K0/IXCUAQN+b6p3r1Or2+qV1NTO/Vms8jT4T9Tw
         NrxeApziWUV3jLRtaComYtwADiBT2zOgvv2+xz1/VYZUXUfzszJszhtTOPW9N4f/vyfx
         kFe1N9jK5fXUYSd7UiYA+QecljiwDNUjF5zbheycfrLtSK2txYL1dugS1mMqe8xIQ5v7
         8ETA==
X-Gm-Message-State: AFuF++kMysxw8jhtGH0bYJOv5sy9N8C1fJBE25em45h6/W41rWsU6Bvs
	+tS3/jLrYGDLdNC/M4f1KiGzB45w45pfIDeYMAVI/4hRFiqVl5Q9tdwu0fakvpU8LvIKlxr1jNp
	M1NCkPrdz++WIifD5xEp5pxW+NSNAw58FcujcO0K9K4K6CT2SaNKaV8+84dXVEtjq4Oc7geqXqj
	XcaI+P/8gcpIKvBSCvPEaDEbjG31Pq6paNjrbe41jVO6XL
X-Gm-Gg: AR+sD13FoC5fmCICFbAyDVZFWSxtQZaQPmt25dgicKp5+MxuwIu2uUlZjBJFh7/OuJq
	xIwN1z820V1ZtC4uzPGQ8wsKh/FTT7P04NenxCEpOxivX9Cq0+etyzw5wBCzpQ+/+rSNOmRYqWQ
	aiW/QgpsIBa1tixuafbIiLCHeLM073OufzVXkVX9OfI4Ir+SltxYAoHPni/D4jEtnVUI1ENdAyn
	6RD/yKoukT2Hz+lGpkVtmy4nuT9YShld25/uEALPyVUzeLu7zPQBKNvL3sSW9ZgZl8INVrrvd2L
	I2yCK1iwD7rHVgrugkIm2RLyXcJy6ITg+Pv9t207EWl7UTdPO9s3SnmiXifxXoe2CqX/E52bAMO
	jjv5Hx7gK6Rd7j9KSiDypGdiqyFVVhHRl8xHyhj/6RCI=
X-Received: by 2002:a05:6830:2b1e:b0:7e9:f8e8:d905 with SMTP id 46e09a7af769-7f4af9cd5c7mr2341830a34.16.1787616819629;
        Mon, 24 Aug 2026 17:13:39 -0700 (PDT)
X-Received: by 2002:a05:6830:2b1e:b0:7e9:f8e8:d905 with SMTP id 46e09a7af769-7f4af9cd5c7mr2341768a34.16.1787616819094;
        Mon, 24 Aug 2026 17:13:39 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc89283sm6433923a34.24.2026.08.24.17.13.38
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:13:38 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/5] Add many missing _requires
Date: Mon, 24 Aug 2026 19:11:07 -0500
Message-ID: <20260825001337.449670-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many tests take actions (chmod, chown, hardlink, mknod) which may not be
supported by simpler filesystems. Often this is fine because other
_require tests already cause the _notrun to occur, but this makes 
it all explicit.

Patch 1 simply removes some spurious "chmod" calls that do not act
on the filesystem under test and AFAICT are not necessary.


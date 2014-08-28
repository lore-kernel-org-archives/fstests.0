Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61218 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935780AbaH1HZW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 03:25:22 -0400
MIME-Version: 1.0
In-Reply-To: <20140827225047.GA4239@infradead.org>
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
	<1409084918-17764-4-git-send-email-pshilovsky@samba.org>
	<20140827155832.GA3103@infradead.org>
	<2DA51A6D-2D91-4582-831B-23C997C37543@gmail.com>
	<20140827225047.GA4239@infradead.org>
Date: Thu, 28 Aug 2014 11:25:22 +0400
Message-ID: <CAKywueRrvG7J7ff+CeX=J6-94xRSo47gKTdBHU0b28XEich5ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cifs: skip tests that need POSIX support for
 nounix mounts
From: Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

2014-08-28 2:50 GMT+04:00 Christoph Hellwig <hch@infradead.org>:
> On Wed, Aug 27, 2014 at 11:49:56PM +0400, Pavel Shilovsky wrote:
>> So for these tests we need two check functions: _require_symlink for 005,
>> 023, 024, 025 and _require_fcntl for 131. Right?
>
> More or less. I'd call the second one _require_fcntl_locks as fcntl
> is a multiplexer for tons of unrelated functionality.

Ok, let's name it this way.

What's about the 1st and 2nd patches? I am going to repost the series
with a new version of the 3rd patch (according to our discussion) and
it'll be better to incorporate their possible changes as well.

-- 
Best regards,
Pavel Shilovsky.

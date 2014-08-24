Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37963 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbaHXKl1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 24 Aug 2014 06:41:27 -0400
MIME-Version: 1.0
In-Reply-To: <20140823114950.GB24896@infradead.org>
References: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
	<20140823114950.GB24896@infradead.org>
Date: Sun, 24 Aug 2014 14:41:27 +0400
Message-ID: <CAKywueT-cYeotYBo1CGk1u2+bLN28OUjm5hpfo5xgQ=DFFV42g@mail.gmail.com>
Subject: Re: [PATCH 0/2] CIFS support for XFS test suite
From: Pavel Shilovsky <pshilovsky@samba.org>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-cifs <linux-cifs@vger.kernel.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

2014-08-23 15:49 GMT+04:00 Christoph Hellwig <hch@infradead.org>:
> On Sat, Aug 23, 2014 at 12:16:01PM +0400, Pavel Shilovsky wrote:
>> These are two patches that adds CIFS support to XFS tests.
>>
>> The first patch adds "-cifs" command line argument and CIFS specific variables. The second patch setups a directory tree for possible CIFS specific tests.
>>
>> With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.
>
> That's against an smb1 server with posix extentions?  don't you need
> various new _require_foo checks for things not support on normal
> SMB1/2/3?

It was tested in posix and non-posix modes.The difference is in tests
005, 023, 024, 131 that are fail on non-posix.

We can add _require_posix() that checks if the mounted filesystem is
cifs and nounix (for example through cat /proc/mounts | grep $TEST_DEV
| grep cifs | grep nounix) and disable the above tests for this case.

-- 
Best regards,
Pavel Shilovsky.

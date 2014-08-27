Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56768 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaH0TuA convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Aug 2014 15:50:00 -0400
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org> <1409084918-17764-4-git-send-email-pshilovsky@samba.org> <20140827155832.GA3103@infradead.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20140827155832.GA3103@infradead.org>
Content-Type: text/plain;
	charset=koi8-r
Content-Transfer-Encoding: 8BIT
Message-Id: <2DA51A6D-2D91-4582-831B-23C997C37543@gmail.com>
From: Pavel Shilovsky <piastryyy@gmail.com>
Subject: Re: [PATCH v2 3/3] cifs: skip tests that need POSIX support for nounix mounts
Date: Wed, 27 Aug 2014 23:49:56 +0400
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Shilovsky <pshilovsky@samba.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>



> 27 авг. 2014 г., в 19:58, Christoph Hellwig <hch@infradead.org> написал(а):
> 
>> On Wed, Aug 27, 2014 at 12:28:38AM +0400, Pavel Shilovsky wrote:
>> CIFS/SMB protocol without POSIX extensions doesn't support operations
>> with symbolic links and advisory byte-range locks from the same process.
>> Add a check for nounix mounts and use it in generic tests that
>> require such operations.
> 
> +_require_test_posix_ext seems very cifs specific.  Can you take
> a look at the tests and see what posix feature they require and
> add features based on that?  Let's have a quick discussion here on the
> requirements of the tests before even writing the code.
> 

Agree.

>> diff --git a/tests/generic/005 b/tests/generic/005
>> index d78e43f..0c2b51f 100755
>> --- a/tests/generic/005
>> +++ b/tests/generic/005
>> @@ -67,6 +67,7 @@ _touch()
>> # real QA test starts here
>> _supported_fs generic
>> _require_test
>> +_require_test_posix_ext
>> 
>> # IRIX UDF does not support symlinks
>> if [ $FSTYP == 'udf' ]; then
> 
> this suggest 005 needs symlinks and plain cifs doesn't support them.
> We should also fold this test for IRIX udf into the _requires_symlink
> tests.
> 
>> diff --git a/tests/generic/023 b/tests/generic/023
>> index 114485c..91b8a37 100755
>> --- a/tests/generic/023
>> +++ b/tests/generic/023
>> @@ -45,6 +45,7 @@ _supported_os Linux
>> 
>> _require_test
>> _requires_renameat2
>> +_require_test_posix_ext
> 
> 
> 023-025 just require a working renameat2, and nothing in Posix.  What's
> the problem for cifs here?

These tests try to create symlinks and then rename them.

> 
>> diff --git a/tests/generic/131 b/tests/generic/131
>> index b4e3ff0..9736963 100755
>> --- a/tests/generic/131
>> +++ b/tests/generic/131
>> @@ -45,6 +45,7 @@ _cleanup()
>> _supported_fs generic
>> _supported_os Linux
>> _require_test
>> +_require_test_posix_ext
>> 
>> TESTFILE=$TEST_DIR/lock_file
> 
> 131 tests fcntl style file locking, so we should test for that.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


So for these tests we need two check functions: _require_symlink for 005, 023, 024, 025 and _require_fcntl for 131. Right?

--
Best regards,
Pavel Shilovsky.
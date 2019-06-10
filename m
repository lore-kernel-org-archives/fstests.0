Received: from mail.cn.fujitsu.com ([183.91.158.132]:7306 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387402AbfFJFeL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Jun 2019 01:34:11 -0400
Message-ID: <5CFDEBCB.2080708@cn.fujitsu.com>
Date: Mon, 10 Jun 2019 13:34:03 +0800
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4/035: skip this test if DAX is in use
References: <20190610024254.9830-1-tytso@mit.edu> <20190610025317.GC3266@mit.edu>
In-Reply-To: <20190610025317.GC3266@mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

on 2019/06/10 10:53, Theodore Ts'o  wrote:
> On Sun, Jun 09, 2019 at 10:42:54PM -0400, Theodore Ts'o wrote:
>> This test creates a file system with a 1k block size.  Since there are
>> no architectures with a 1k page size, test file system can never be
> s/test file system/the test file system/
>
>> mounted with DAX enabled, causing the test to fail.
Looks good to me. Feel free to add:
Reviewed-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>

> Sorry, typo.
>
> 						- Ted
>
>
>

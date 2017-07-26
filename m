Received: from mail-yw0-f171.google.com ([209.85.161.171]:33648 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdGZSDy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jul 2017 14:03:54 -0400
Received: by mail-yw0-f171.google.com with SMTP id x125so92545847ywa.0
        for <fstests@vger.kernel.org>; Wed, 26 Jul 2017 11:03:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726180216.7359-1-tahsin@google.com>
References: <20170726085500.GX9167@eguan.usersys.redhat.com> <20170726180216.7359-1-tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
Date: Wed, 26 Jul 2017 11:03:52 -0700
Message-ID: <CAAeU0aOnpLbimZOj=xLF3PB8kgLEaWa75vv4S-H0-WcPbYM8uw@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: add a test for ea_inode feature
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, fstests@vger.kernel.org
Cc: Tahsin Erdogan <tahsin@google.com>
List-ID: <fstests@vger.kernel.org>

>> The actual block size is not that important for the purposes of this
>> test. However, knowing the block size helps simplifying the test
>> because we can hardcode xattr value sizes in the rest of the script.
>> I've set block size to 4k in case ext4 default changes in the future.
>
> In this case, what we generally do is filtering the output and make it
> consistent across different block size ext4 filesystems, instead of
> hardcoding the block size in test, so we have better test coverage.

Got it. I removed the hardcoded sizes. Thanks!

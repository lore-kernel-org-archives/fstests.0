Received: from mail-yw0-f179.google.com ([209.85.161.179]:36127 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdGYSUj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2017 14:20:39 -0400
Received: by mail-yw0-f179.google.com with SMTP id u207so12077322ywc.3
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2017 11:20:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725180615.8091-1-tahsin@google.com>
References: <20170725180528.7829-1-tahsin@google.com> <20170725180615.8091-1-tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
Date: Tue, 25 Jul 2017 11:20:38 -0700
Message-ID: <CAAeU0aMAPWVv00bmU2wy89cF_zpxo9PFL+tjaacoHVtORXj1Tg@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: add a test for ea_inode feature
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, fstests@vger.kernel.org
Cc: Tahsin Erdogan <tahsin@google.com>
List-ID: <fstests@vger.kernel.org>

Eryu, thanks for the feedback!

>> +# FS QA Test 026
>> +#
>> +# Test ea_inode feature.
>
> Better to have more information about ea_inode feature and what this
> case tests here too.

Done.

>> +_scratch_mkfs_ext4 -O ea_inode -I 256 -b 4096 >/dev/null 2>&1
>
> Is 4k block size a hard requirement? If not, then we lose test coverage
> for 1k/2k block size ext4, if so, some comments on it would be better.
> (and the 256 inode size too).

The actual block size is not that important for the purposes of this
test. However, knowing the block size helps simplifying the test
because we can hardcode xattr value sizes in the rest of the script.
I've set block size to 4k in case ext4 default changes in the future.

>> +     if [[ "$value" != "" ]]; then
>> +             setfattr -n $name -v "$value" $file
>
> You can use $SETFATTR_PROG and $GETFATTR_PROG in the test.

Done.

>> +
>> +     tmp=$(getfattr --absolute-names --only-values -n $name $file)
>> +     [[ $tmp == $value ]] || echo "unexpected value returned: $tmp"
>
> Better to get $tmp and $value quoted with "", otherwise if any value is
> empty, it's a bash syntax error.

Done.
